import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  Future<void> sendOTP(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(minutes: 2 ),
        // 
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification if possible (usually on Android)
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          String message;
          switch (e.code) {
            case 'invalid-phone-number':
              message = 'The provided phone number is invalid.';
              break;
            case 'too-many-requests':
              message = 'Too many requests. Try again later.';
              break;
            default:
              message = 'Verification failed. Please try again.';
          }
          throw Exception(message);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      throw Exception('Failed to send OTP: ${e.toString()}');
    }
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      if (_verificationId == null) {
        throw Exception('No verification ID found. Please request OTP first.');
      }

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-verification-code':
          message = 'Invalid OTP. Please try again.';
          break;
        case 'invalid-verification-id':
          message = 'Invalid verification. Please request new OTP.';
          break;
        default:
          message = 'Verification failed: ${e.message}';
      }
      throw Exception(message);
    } catch (e) {
      throw Exception('Failed to verify OTP: ${e.toString()}');
    }
  }

  Future<void> saveUserDetails(String name, String address) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', name);
      await prefs.setString('user_address', address);

      // Save to Firebase user profile if needed
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(name);
      }
    } catch (e) {
      throw Exception('Failed to save user details: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }
}