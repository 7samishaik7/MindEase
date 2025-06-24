import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils.dart';
import '../../providers/auth_provider.dart';

class RegisterScreen extends ConsumerWidget {
  RegisterScreen({super.key});

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.read(authServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Name')),
            TextField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email')),
            TextField(
              controller: _passCtrl,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final success = await authService.register(
                  _emailCtrl.text,
                  _passCtrl.text,
                  _nameCtrl.text,
                );
                if (success) {
                  showSnack(context, "Account created! Please login.");
                  Navigator.pop(context);
                } else {
                  showSnack(context, "Registration failed", isError: true);
                }
              },
              child: const Text('Register'),
            )
          ],
        ),
      ),
    );
  }
}
