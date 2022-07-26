// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

import '../models/Users.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create anon user
  Users _users(User? user) {
    return Users(uid: user!.uid);
  }

  //check authentication changes.
  //will give uid if signed in, null if signed out.
  Stream<Users> get user {
    return _auth
        .authStateChanges()
        //.map((User? user) => _users(user));
        .map(_users);
  }

  //method for sign-in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _users(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //method for sign-in with email

  //method for registering with email

  //method for sign-out
  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
