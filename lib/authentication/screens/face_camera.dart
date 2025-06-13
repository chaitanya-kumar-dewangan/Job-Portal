import 'dart:io';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'information.dart';

class FaceCameraScreen extends StatefulWidget {
  final String userId;
  final String phoneNumber;

  const FaceCameraScreen({
    super.key,
    required this.userId,
    required this.phoneNumber,
  });

  @override
  State<FaceCameraScreen> createState() => _FaceCameraScreenState();
}

class _FaceCameraScreenState extends State<FaceCameraScreen> {
  File? _capturedImage;
  FaceCameraController? controller;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initCamera());
  }

  Future<void> initCamera() async {
    await FaceCamera.initialize();
    setState(() {
      controller = FaceCameraController(
        autoCapture: true,
        defaultCameraLens: CameraLens.front,
        performanceMode: FaceDetectorMode.accurate,
        orientation: CameraOrientation.portraitUp,
        onCapture: (File? image) async {
          if (image != null) {
            File croppedImage = await _cropAndRotateImage(image);
            setState(() => _capturedImage = croppedImage);
          }
        },
        onFaceDetected: (Face? face) {
          debugPrint(face != null ? "Face detected" : "No face detected");
        },
      );
      _isCameraInitialized = true;
    });
  }

  Future<File> _cropAndRotateImage(File imageFile, {int angle = 270}) async {
    final bytes = await imageFile.readAsBytes();
    img.Image? image = img.decodeImage(bytes);
    if (image == null) return imageFile;

    int size = image.width < image.height ? image.width : image.height;
    img.Image cropped = img.copyCrop(
      image,
      x: 0,
      y: 0,
      width: size,
      height: size,
    );

    final processedFile = File(imageFile.path)
      ..writeAsBytesSync(img.encodeJpg(cropped));
    return processedFile;
  }

  Future<String?> _uploadImageAndReturnUrl(File file) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('User not logged in')));
      return null;
    }

    try {
      final fileExt = path.extension(file.path);
      final fileName =
          'profile_${DateTime.now().millisecondsSinceEpoch}$fileExt';
      final filePath = 'profile_pics/$fileName';

      final imageBytes = await file.readAsBytes();

      await supabase.storage
          .from('users')
          .uploadBinary(
        filePath,
        imageBytes,
        fileOptions: const FileOptions(
          contentType: 'image/jpeg',
          upsert: true,
        ),
      );

      final imageUrl = supabase.storage.from('users').getPublicUrl(filePath);
      debugPrint("Image uploaded: $imageUrl");
      return imageUrl;
    } catch (e) {
      debugPrint('Upload error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Image upload failed')));
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a Selfie')),
      body:
      _capturedImage != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.file(
              _capturedImage!,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    await controller?.startImageStream();
                    setState(() => _capturedImage = null);
                  },
                  child: const Icon(Icons.refresh),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    if (_capturedImage != null) {
                      final imageUrl = await _uploadImageAndReturnUrl(
                        _capturedImage!,
                      );
                      if (imageUrl != null) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder:
                                (context) => Information(
                              imageUrl: imageUrl,
                              userId: widget.userId,
                              phoneNumber: widget.phoneNumber,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: const Icon(Icons.check),
                ),
              ],
            ),
          ],
        ),
      )
          : _isCameraInitialized && controller != null
          ? SmartFaceCamera(
        showControls: false,
        controller: controller!,
        messageBuilder: (context, face) {
          if (face == null) {
            return _message('Place your face in the camera');
          }
          if (!face.wellPositioned) {
            return _message('Center your face in the square');
          }
          return const SizedBox.shrink();
        },
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _message(String msg) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    child: Text(
      msg,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),
  );

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
