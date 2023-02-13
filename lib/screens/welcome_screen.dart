import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/divider_label.dart';
import 'package:flash_chat/components/form_textfield.dart';
import 'package:flash_chat/components/square_icon_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = "/welcome";
  WelcomeScreen({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 40,
              ),
              Hero(
                tag: "logo_tag",
                child: SizedBox(
                  height: 80.0,
                  child: Image.asset(kLogo),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Jokie Chats",
                    speed: const Duration(milliseconds: 250),
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 25),
              FormTextField(
                controller: usernameController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              FormTextField(
                controller: passwordController,
                hintText: "Password",
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(right: 25),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 25.0),
              RoundedButton(
                text: "Sign In",
                onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
              ),
              const SizedBox(height: 30),
              const Dividerlabel(labelText: "Or Continue With"),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareIconButton(iconData: FontAwesomeIcons.google),
                  SquareIconButton(iconData: FontAwesomeIcons.phone),
                  SquareIconButton(iconData: FontAwesomeIcons.apple),
                ],
              ),
              const SizedBox(height: 30),
              const Dividerlabel(labelText: "Not Registered?"),
              RoundedButton(
                text: "Sign Up",
                onPressed: () =>
                    Navigator.pushNamed(context, RegistrationScreen.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}