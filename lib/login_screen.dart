import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String message = '';

  void loginUser() async {
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      setState(() {
        message = 'Login successful!';
      });
    } catch (e) {
      setState(() {
        message = 'Login failed: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Login")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration:
              InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              decoration:
              InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: loginUser,
              child: Text('Login'),
            ),
            SizedBox(height: 15),
            Text(
              message,
              style: TextStyle(color: message.contains('successful') ? Colors.green : Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
