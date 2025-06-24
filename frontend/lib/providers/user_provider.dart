import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/user_service.dart';

final userServiceProvider = Provider<UserService>((ref) => UserService());

final currentUserProvider = FutureProvider<User?>((ref) async {
  final service = ref.read(userServiceProvider);
  return await service.getProfile();
});
