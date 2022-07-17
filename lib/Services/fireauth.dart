// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //method for sign-in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //method for sign-in with email

  //method for registering with email

  //method for sign-out
}
