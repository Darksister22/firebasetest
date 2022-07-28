import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final googlesignin =
      GoogleSignIn(); //creating an instance of google sign in class.
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user =>
      _user!; //getting the user info inside the user instance.

  Future googleLogin() async {
    final googleuser =
        await googlesignin.signIn(); //show the pop-up to select a user account.
    if (googleuser == null) {
      return;
    }
    _user = googleuser; //save the user account.
    final googleAuth = await googleuser
        .authentication; //getting the authentication data of the google user.
    final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth
            .idToken); //saving the credentials, used to sign in with firebase.
    await _auth.signInWithCredential(
        credentials); //this will send the access and ID tokens to sign in with firebase.
    notifyListeners();
  }

  Future googleLogout() async {
    await googlesignin.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
