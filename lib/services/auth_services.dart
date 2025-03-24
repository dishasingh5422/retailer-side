// Inside auth_services.dart where your AuthService class is defined

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> sendOTP(String phoneNumber) async {
    // your existing sendOTP implementation
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      // your existing verifyOTP implementation
      // Example: Replace this with actual OTP verification logic
      if (otp == "123456") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Handle any exceptions
      throw Exception("OTP verification failed: $e");
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Existing for customers:
  Future<void> saveUserDetails(String name, String address) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('customers').doc(user.uid).set({
        'name': name,
        'address': address,
        'phone': user.phoneNumber,
        'role': 'customer',
      });
    }
  }

  // NEW: For Retailers 👇
  Future<void> saveRetailerDetails(String shopName, String shopAddress) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('retailers').doc(user.uid).set({
        'shopName': shopName,
        'shopAddress': shopAddress,
        'phone': user.phoneNumber,
        'role': 'retailer',
      });
    }
  }
}
