// retailer_auth_provider.dart
import 'package:flutter/foundation.dart';
import 'package:ems_v1/services/auth_services.dart';

class RetailerAuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  String _name = '';
  String _address = '';
  String _phoneNumber = '';
  String _otp = '';
  String _shopName = '';
  String _shopAddress = '';
  bool _isLoading = false;

  String get phoneNumber => _phoneNumber;
  bool get isLoading => _isLoading;
  

  void setPhone(String phone) {
    _phoneNumber = '+91$phone'; 
    notifyListeners();
  }

  void setUserDetails(String name, String address) {
    _name = name;
    _address = address;
    notifyListeners();
  }

  void setOTP(String otp) {
    _otp = otp;
    notifyListeners();
  }

  void setRetailerDetails(String shopName, String shopAddress) {
    _shopName = shopName;
    _shopAddress = shopAddress;
    notifyListeners();
  }

  bool isValidPhone() {
    return _phoneNumber.length >= 13; 
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
      if (result && _shopName.isNotEmpty && _shopAddress.isNotEmpty) {
        await _authService.saveRetailerDetails(_shopName, _shopAddress);
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
    _shopName = '';
    _shopAddress = '';
    notifyListeners();
  }
}
