import 'package:ask/authentication/services/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';
import 'face_camera.dart';

class OTPVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OTPVerificationPage({super.key, required this.phoneNumber});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final AuthService _authService = AuthService();
  final TextEditingController otpController = TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;

  bool isLoading = false;

  Future<void> verifyOTP() async {
    final otp = otpController.text.trim();
    if (otp.isNotEmpty) {
      final response = await _authService.verifyOTP(
        phoneNumber: widget.phoneNumber,
        otp: otp,
      );

      if (response?.user != null) {
        String userId = response!.user!.id;

        // Check if user exists in 'users' table
        final userData =
            await Supabase.instance.client
                .from('users')
                .select()
                .eq('user_id', userId) // Correct column key
                .maybeSingle();

        if (userData != null) {
          // User found → Navigate to FoodCategoryScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage()
            ),
          );
        } else {
          // User not found → Navigate to Information screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => FaceCameraScreen(
                    userId: userId,
                    phoneNumber: widget.phoneNumber,
                  ),
            ),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => Information(
          //       userId: userId,
          //       phoneNumber: widget.phoneNumber,
          //     ),
          //   ),
          // );
        }
      } else {
        // Invalid OTP → Show toast
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text("Invalid OTP. Please try again.")),
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 160,
            color: Colors.yellow.shade900, // Bright yellow-orange
            child: Stack(
              children: [
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "We’re glad you’re here! Dive into a world of delicious flavors, fast service, and seamless experiences made just for you.",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Verify OTP",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFFFF3CD), // light yellow
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: isLoading ? null : verifyOTP,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade900, // deep red
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        fixedSize: const Size(200, 48),
                      ),
                      child:
                          isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : const Text(
                                "Verify",
                                style: TextStyle(color: Colors.white),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
