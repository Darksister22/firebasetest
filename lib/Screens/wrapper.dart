import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/Screens/Auth/verify.dart';
import 'package:flutter/material.dart';

import 'Auth/auth.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        //the stream builder will listen for authentication changes.
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return EmailVerify();
          } else {
            return Authenticate();
          }
        }),
      ),
    );
  }
}
