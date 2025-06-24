import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'api_client.dart';

class AuthService {
  final ApiClient _client = ApiClient();

  Future<bool> login(String email, String password) async {
    final res = await _client.post('/auth/login', {
      'email': email,
      'password': password,
    });

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['access_token']);
      return true;
    }
    return false;
  }

  Future<bool> register(String email, String password, String name) async {
    final res = await _client.post('/auth/register', {
      'email': email,
      'password': password,
      'name': name,
    });

    return res.statusCode == 201;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
