import 'package:flutter/material.dart';
import '../models/auth_response.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  User? _user;

  String? get token => _token;
  User? get user => _user;
  bool get isLoggedIn => _token != null;

  Future<void> signup(String name, String email, String password) async {
    print("[AuthProvider] Signup started with name=$name, email=$email");
    try {
      _user = await AuthService.signup(name, email, password);
      print("[AuthProvider] Signup successful, user=${_user?.name}");
    } catch (e) {
      print("[AuthProvider] Signup failed: $e");
      rethrow;
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    print("[AuthProvider] Login started with email=$email");
    try {
      AuthResponse res = await AuthService.login(email, password);
      _token = res.accessToken;
      print("[AuthProvider] Login successful, token=$_token");
    } catch (e) {
      print("[AuthProvider] Login failed: $e");
      rethrow;
    }
    notifyListeners();
  }

  void logout() {
    print("[AuthProvider] Logging out...");
    _token = null;
    _user = null;
    notifyListeners();
    print("[AuthProvider] Logout complete");
  }
}
