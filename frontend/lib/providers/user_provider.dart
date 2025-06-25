import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser;
  String? _token;

  User? get currentUser => _currentUser;

  Future<void> fetchUserProfile(String token) async {
    _token = token; // store if needed later
    try {
      _currentUser = await UserService.getProfile(token);
      notifyListeners();
    } catch (e) {
      print("[UserProvider] Failed to fetch user: $e");
    }
  }

  void clearUser() {
    _currentUser = null;
    _token = null;
    notifyListeners();
  }
}
