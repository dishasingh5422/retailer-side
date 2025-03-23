import 'package:flutter/foundation.dart';
import 'package:ems_v1/services/auth_services.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  String _phoneNumber = '';
  String _otp = '';
  String _name = '';
  String _address = '';
  bool _isLoading = false;

  String get phoneNumber => _phoneNumber;
  bool get isLoading => _isLoading;

  void setPhone(String phone) {
    _phoneNumber = '+91$phone'; // Adding country code for India
    notifyListeners();
  }

  void setOTP(String otp) {
    _otp = otp;
    notifyListeners();
  }

  void setUserDetails(String name, String address) {
    _name = name;
    _address = address;
    notifyListeners();
  }

  bool isValidPhone() {
    // Phone number should be 10 digits (excluding country code)
    return _phoneNumber.length >= 13; // Including +91
  }

  Future<void> sendOTP() async {
    if (!isValidPhone()) {
      throw Exception('Invalid phone number');
    }
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.sendOTP(_phoneNumber);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> verifyOTP() async {
    if (_otp.length != 6) {
      throw Exception('Invalid OTP');
    }
    _isLoading = true;
    notifyListeners();
    try {
      final result = await _authService.verifyOTP(_otp);
      if (result && _name.isNotEmpty && _address.isNotEmpty) {
        await _authService.saveUserDetails(_name, _address);
      }
      return result;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _phoneNumber = '';
    _otp = '';
    _name = '';
    _address = '';
    notifyListeners();
  }
}