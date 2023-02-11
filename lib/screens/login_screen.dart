import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  String _email = "";
  String _password = "";

  void loginUser() async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      if (user != null) {
        Navigator.pushReplacementNamed(context, ChatScreen.id);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: "logo_tag",
              child: SizedBox(
                height: 200.0,
                child: Image.asset(kLogo),
              ),
            ),
            const SizedBox(height: 48.0),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                _email = value;
              },
              decoration: kTextFieldDecoration(
                  hint: "Enter your email", color: Colors.lightBlueAccent),
            ),
            const SizedBox(height: 8.0),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                _password = value;
              },
              decoration: kTextFieldDecoration(
                  hint: "Enter your password", color: Colors.lightBlueAccent),
            ),
            const SizedBox(height: 24.0),
            RoundedButton(
              text: "Submit",
              color: Colors.lightBlueAccent,
              onPressed: () {
                loginUser();
              },
            ),
          ],
        ),
      ),
    );
  }
}
