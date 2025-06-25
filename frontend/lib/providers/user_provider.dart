import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  final UserService _userService = UserService();

  Future<void> fetchUserProfile() async {
    try {
      _currentUser = await _userService.getProfile();
      notifyListeners();
    } catch (e) {
      print("[UserProvider] Failed to fetch user: $e");
    }
  }

  void clearUser() {
    _currentUser = null;
    notifyListeners();
  }
}
