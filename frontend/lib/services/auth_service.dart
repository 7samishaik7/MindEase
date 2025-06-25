import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/constants.dart';
import '../models/auth_response.dart';

class AuthService {
  /// User signup
  static Future<AuthResponse> signup(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(_extractErrorMessage(response.body));
    }
  }

  /// User login
  static Future<AuthResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(_extractErrorMessage(response.body));
    }
  }

  /// Helper to extract `detail` error message from backend
  static String _extractErrorMessage(String responseBody) {
    try {
      final decoded = jsonDecode(responseBody);
      return decoded['detail'] ?? 'Unknown error';
    } catch (e) {
      return 'Unexpected error occurred';
    }
  }
}
