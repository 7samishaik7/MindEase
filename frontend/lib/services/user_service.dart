import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';
import 'api_client.dart';
import '../core/constants.dart';

// Define your baseUrl here or import it from a config file

class UserService {
  final ApiClient _client = ApiClient();

 static Future<User> getProfile(String token) async {
  final response = await http.get(
    Uri.parse('$baseUrl/auth/me'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch user profile');
  }
}

}
