import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/rounded_button.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "/registration";
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  String _email = "";
  String _password = "";
  bool _isBusy = false;

  void createUserAccount() async {
    if (_isBusy) return;
    try {
      setState(() => _isBusy = true);
      final user = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      if (user != null) {
        Navigator.pushReplacementNamed(context, ChatScreen.id);
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _isBusy,
        child: Padding(
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
                    hint: "Enter your email", color: Colors.blueAccent),
              ),
              const SizedBox(height: 8.0),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  _password = value;
                },
                decoration: kTextFieldDecoration(
                    hint: "Enter your password", color: Colors.blueAccent),
              ),
              const SizedBox(height: 24.0),
              RoundedButton(
                text: "Submit",
                color: Colors.blueAccent,
                onPressed: () async {
                  createUserAccount();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
