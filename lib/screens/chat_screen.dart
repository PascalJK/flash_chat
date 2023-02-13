import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

User? _currentUser;

class ChatScreen extends StatefulWidget {
  static const String id = "/group_chat";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageTextController = TextEditingController();
  String _message = "";

  @override
  void initState() {
    getCurrentUser();
    // messagesStream();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      _currentUser = _auth.currentUser;
    } catch (e) {
      print(e);
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection("messages").snapshots()) {
      for (var message in snapshot.docs) {
        print("${message.data()} + ${message.id}");
      }
    }
  }

  void sendMessage() {
    var data = {
      "message": _message.trim(),
      "senderUid": _currentUser!.uid,
      "email": _currentUser!.email,
      "timeStamp": Timestamp.now(),
    };
    _firestore.collection("messages").add(data);
    _messageTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                _auth.signOut();
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageTextController,
                      onChanged: (value) {
                        _message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      sendMessage();
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore.collection("messages").orderBy("timeStamp").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> messagaeBubble = [];
          for (var message in snapshot.data!.docs.reversed) {
            final data = message.data() as Map;
            if (_currentUser!.uid == data["senderUid"]) {
              messagaeBubble.add(InBoundMessageBubble(data: data));
            } else {
              messagaeBubble.add(OutBoundMessageBubble(data: data));
            }
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: messagaeBubble,
            ),
          );
        }
        return const Center(child: Text("Empty"));
      },
    );
  }
}

class InBoundMessageBubble extends StatelessWidget {
  const InBoundMessageBubble({
    super.key,
    required this.data,
  });

  final Map data;

  String getTimestampToDate() {
    var ts = (data['timeStamp'] as Timestamp).toDate().toLocal();
    return "${ts.day}/${ts.month}/${ts.hour}/${ts.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Material(
            color: Colors.lightBlueAccent,
            elevation: 5,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "${data['message']}",
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
          const SizedBox(height: 1),
          Text(
            getTimestampToDate(),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class OutBoundMessageBubble extends StatelessWidget {
  const OutBoundMessageBubble({
    super.key,
    required this.data,
  });

  final Map data;

  String getTimestampToDate() {
    var ts = (data['timeStamp'] as Timestamp).toDate().toLocal();
    return "${ts.day}/${ts.month}/${ts.hour}/${ts.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data['email'],
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
            color: Colors.lightGreenAccent,
            elevation: 5,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "${data['message']}",
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
          const SizedBox(height: 1),
          Text(
            getTimestampToDate(),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
