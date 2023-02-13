import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/view_models/signup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/divider_label.dart';
import '../components/form_textfield.dart';
import '../components/rounded_button.dart';
import '../components/square_icon_button.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "/registration";
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var viewModel = SignUpViewModel();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ModalProgressHUD(
            inAsyncCall: viewModel.isBusy,
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
                const SizedBox(height: 15),
                const Dividerlabel(labelText: "Or Sign up With"),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareIconButton(iconData: FontAwesomeIcons.google),
                    SquareIconButton(iconData: FontAwesomeIcons.phone),
                    SquareIconButton(iconData: FontAwesomeIcons.apple),
                  ],
                ),
                const SizedBox(height: 24.0),
                RoundedButton(
                  text: "Submit",
                  onPressed: () async {
                    if (viewModel.isBusy) return;
                    try {
                      setState(() => viewModel.isBusy = true);
                      await viewModel.createUserAccount(context);
                    } catch (e) {
                      print(e);
                    } finally {
                      setState(() => viewModel.isBusy = false);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
