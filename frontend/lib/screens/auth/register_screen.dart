import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void handleSignup() async {
    try {
      await Provider.of<AuthProvider>(context, listen: false).signup(
        nameController.text,
        emailController.text,
        passwordController.text,
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Signup successful')));
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name')),
        TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email')),
        TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true),
        ElevatedButton(onPressed: handleSignup, child: Text('Sign Up')),
      ]),
    );
  }
}
