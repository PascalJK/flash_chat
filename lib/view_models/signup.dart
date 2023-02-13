import 'package:flash_chat/view_models/base.dart';
import 'package:flutter/material.dart';

import '../screens/chat_screen.dart';

class SignUpViewModel extends BaseViewModel {
  Future createUserAccount(BuildContext context) async {
    // if (isBusy) return;
    // try {
    // setState(() => isBusy = true);
    final user = await auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    if (user.user != null) {
      Navigator.pushReplacementNamed(context, ChatScreen.id);
    }
    // } catch (e) {
    //   print(e);
    // } finally {
    //   setState(() => isBusy = false);
    // }
  }
}
