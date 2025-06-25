import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'bottom_nav.dart';
import '../mood/mood_input_screen.dart';
import '../journal/journal_list_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      MoodInputScreen(),
      JournalListScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("MindEase"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();
              // Optionally: redirect to login screen
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
