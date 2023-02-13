import 'package:flash_chat/view_models/base.dart';
import 'package:flutter/material.dart';

import '../screens/chat_screen.dart';

class LoginViewModel extends BaseViewModel {

  Future loginUser(BuildContext context) async {
    // if (isBusy) return;
    // try {
      // setState(() => isBusy = true);
      await Future.delayed(const Duration(seconds: 3));
      final user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        Navigator.pushReplacementNamed(context, ChatScreen.id);
      }
    // } catch (e) {
    //   print(e);
    // } finally {
    //   // setState(() => isBusy = false);
    // }
  }
}
