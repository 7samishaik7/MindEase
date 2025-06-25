import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/mood_provider.dart';
import 'providers/journal_provider.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MoodProvider()),
        ChangeNotifierProvider(create: (_) => JournalProvider()),
      ],
      child: const MindEaseApp(),
    ),
  );
}

class MindEaseApp extends StatelessWidget {
  const MindEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      title: 'MindEase',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: authProvider.isLoggedIn ? const HomeScreen() : const LoginScreen(),
      routes: {
        '/home': (_) => const HomeScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => RegisterScreen(), // 👈 Ensure this exists
      },
    );
  }
}
