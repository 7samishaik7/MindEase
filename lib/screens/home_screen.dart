import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/bottom_nav.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  static final List<Widget> _tabs = <Widget>[
    Center(child: Text('Mood Check-In')), // TODO: replace with MoodScreen()
    Center(child: Text('Journal')), // TODO: replace with JournalScreen()
    Center(child: Text('Support')), // TODO: replace with SupportScreen()
    Center(child: Text('Profile')), // TODO: replace with ProfileScreen()
  ];

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
