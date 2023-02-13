import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/divider_label.dart';
import 'package:flash_chat/components/form_textfield.dart';
import 'package:flash_chat/components/square_icon_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/view_models/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "/welcome";
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final viewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: viewModel.isBusy,
        child: SafeArea(
          child: Center(
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
                    controller: emailController,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => viewModel.email = value,
                  ),
                  const SizedBox(height: 10),
                  FormTextField(
                    controller: passwordController,
                    hintText: "Password",
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    onChanged: (value) => viewModel.password = value,
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
                    onPressed: () async {
                      if (viewModel.isBusy) return;
                      try {
                        setState(() => viewModel.isBusy = true);
                        await viewModel.loginUser(context);
                      } catch (e) {
                        print(e);
                      } finally {
                        setState(() => viewModel.isBusy = false);
                      }
                    },
                  ),
                  const SizedBox(height: 10),
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
        ),
      ),
    );
  }
}
