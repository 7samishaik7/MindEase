import 'dart:convert';
import '../models/user.dart';
import 'api_client.dart';

class UserService {
  final ApiClient _client = ApiClient();

  Future<User?> getProfile() async {
    final res = await _client.get('/user/profile');
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    }
    return null;
  }
}
