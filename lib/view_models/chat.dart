import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/view_models/base.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends BaseViewModel {
  String message = "";

  void messagesStream() async {
    await for (var snapshot in firestore.collection("messages").snapshots()) {
      for (var message in snapshot.docs) {
        print("${message.data()} + ${message.id}");
      }
    }
  }

  void sendMessage() {
    var data = {
      "message": message.trim(),
      "senderUid": auth.currentUser!.uid,
      "email": auth.currentUser!.email,
      "timeStamp": Timestamp.now(),
    };
    firestore.collection("messages").add(data);
  }

  void signOut(BuildContext context) async{
    await auth.signOut();
    Navigator.pushReplacementNamed(context, WelcomeScreen.id);
  }
}
