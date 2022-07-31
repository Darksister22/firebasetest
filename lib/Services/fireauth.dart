// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/Services/database.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/Users.dart';
import 'handler.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googlesignin = GoogleSignIn();
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
      //  print(e.toString());
      rethrow;
    }
  }

  //method for sign-in with email
  Future loginEmail(String email, String password) async {
    var _status = AuthStatus.unknown;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(_auth.currentUser!.emailVerified);
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    return _status;
  }

  //method for resestting password
  Future resetPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //method for registering with email
  Future registerEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? newUser = result.user;
      //create a new document.
      await DataBaseService(uid: newUser!.uid)
          .updateUserData('0', 'fatema', 100);

      return _users(newUser);
    } catch (e) {
      rethrow;
    }
  }

  //method for sending verification email
  Future sendVerificationEmail() async {
    await _auth.currentUser!.sendEmailVerification();
  }

  //method for sign-out
  Future logOut() async {
    try {
      //await googlesignin.disconnect();
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
