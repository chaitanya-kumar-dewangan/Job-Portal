import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../models/users_model.dart';
// import '../../home/screen/home_screen.dart';

class Information extends StatefulWidget {
  final String imageUrl;
  final String userId;
  final String phoneNumber;

  const Information({
    super.key,
    required this.userId,
    required this.phoneNumber,
    required this.imageUrl,
  });

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  final SupabaseClient _supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  bool isLoading = false;

  // Updated saveUserData method to use the imageUrl from widget directly
  Future<void> saveUserData() async {
    if (!_formKey.currentState!.validate()) {
      return; // If validation fails, stop execution
    }

    setState(() => isLoading = true);

    try {
      // Create an instance of UserModel
      UserModel user = UserModel(
        id: widget.userId,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phoneNumber: widget.phoneNumber,
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        pincode: postalCodeController.text.trim(),
        state: stateController.text.trim(),
        profilePicUrl: widget.imageUrl, // Use the imageUrl from the widget
      );

      // Update the user data in Supabase
      await _supabase.from('users').upsert({
        'user_id': user.id,
        'name': user.name,
        'phone_number': user.phoneNumber,
        'email': user.email,
        'address_line': user.address,
        'city': user.city,
        'state': user.state,
        'postal_code': user.pincode,
        'profile_pic_url': user.profilePicUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User data saved successfully!")),

      );
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => FoodCategoryScreen(userId: widget.userId)),
      // );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save data: $error")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade900,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "New Account",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      buildField("Full name", nameController),
                      buildField("Email", emailController, isEmail: true),
                      buildField("Address", addressController),
                      buildField("City", cityController),
                      buildField("Postal Code", postalCodeController, isNumeric: true),
                      buildField("State", stateController),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          "By continuing, you agree to\nTerms of Use and Privacy Policy.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : saveUserData,  // Directly call saveUserData since it uses widget.imageUrl
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade700,
                            fixedSize: const Size(200, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildField(String label, TextEditingController controller,
      {bool isEmail = false, bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType:
            isNumeric ? TextInputType.number : TextInputType.text,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              filled: true,
              fillColor: const Color(0xFFFFF2B3), // Soft yellow
              hintText: "Enter $label",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "This field is required";
              }
              if (isEmail &&
                  !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
                return "Enter a valid email";
              }
              if (isNumeric && !RegExp(r'^\d+$').hasMatch(value.trim())) {
                return "Enter a valid number";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
