import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> sendOTP(String phoneNumber) async {
    try {
      await _supabase.auth.signInWithOtp(phone: phoneNumber);
      print("✅ OTP Sent Successfully to $phoneNumber");
    } catch (e) {
      print("❌ Error sending OTP: $e");
      throw e; // Pass error to UI
    }
  }

  // Verify OTP and return user details
  Future<AuthResponse?> verifyOTP({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final response = await _supabase.auth.verifyOTP(
        phone: phoneNumber,
        token: otp,
        type: OtpType.sms,
      );

      if (response.user != null) {
        return response;
      }
    } catch (e) {
      print("Error verifying OTP: $e");
    }
    return null;
  }

  // Store user details in Supabase
  Future<void> storeUserDetails({
    required String userId,
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required String city,
    required String postalCode,
  }) async {
    await _supabase.from('users').upsert({
      'user_id': userId,
      'name': name,
      'email': email,
      'phone': phoneNumber, // ✅ Store phone number
      'address': address,
      'city': city,
      'postal_code': postalCode,
    });
  }
}
