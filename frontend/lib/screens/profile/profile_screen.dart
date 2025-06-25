import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: user == null
          ? const Center(child: Text("Not logged in"))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${user.name}",
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text("Email: ${user.email}",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                    onPressed: () {
                      authProvider.logout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
