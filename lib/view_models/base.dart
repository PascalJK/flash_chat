import 'package:firebase_auth/firebase_auth.dart';

class BaseViewModel{
  final auth = FirebaseAuth.instance;
  
  String email = "";
  String password = "";
  bool isBusy = false;
}