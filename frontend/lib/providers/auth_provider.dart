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

  /// Sign up method
  Future<void> signup(String name, String email, String password) async {
    print("[AuthProvider] Signup started with name=$name, email=$email");
    try {
      // You can return user info if your backend gives it. Currently we mock it.
      final authResponse = await AuthService.signup(name, email, password);
      _token = authResponse.token;

      
      print("[AuthProvider] Signup successful, token=$_token");

      // Optional: Fetch user info here if needed
    } catch (e) {
      print("[AuthProvider] Signup failed: $e");
      rethrow;
    }
    notifyListeners();
  }

  /// Login method
  Future<AuthResponse> login(String email, String password) async {
    print("[AuthProvider] Login started with email=$email");
    try {
      final res = await AuthService.login(email, password);
      _token = res.token;

      
      print("[AuthProvider] Login successful, token=$_token");

      notifyListeners();
      return res; // Return the response so other providers can use the token
    } catch (e) {
      print("[AuthProvider] Login failed: $e");
      rethrow;
    }
  }

  /// Logout method
  void logout() {
    print("[AuthProvider] Logging out...");
    _token = null;
    _user = null;
    notifyListeners();
    print("[AuthProvider] Logout complete");
  }
}
 