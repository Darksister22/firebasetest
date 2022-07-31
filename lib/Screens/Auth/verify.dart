import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/Services/fireauth.dart';
import 'package:flutter/material.dart';

import '../home/home.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({Key? key}) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  bool isVerified = false;
  Timer? timer;

  final AuthService _auth = AuthService();

//cancel the timer if it's unused for too long.
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    isVerified = FirebaseAuth
        .instance.currentUser!.emailVerified; //get verification status.
    if (!isVerified) {
      _auth.sendVerificationEmail(); //will send a verification email.
    }
    //The tutorial is using a timer to check if the email is verified.

    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      checkEmailVerified();
    });
    if (isVerified) {
      timer?.cancel();
    }
  }

  //checking if the email is verified
  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
  }

  @override
  Widget build(BuildContext context) =>
      isVerified //check verification and return either the home page or a please verify page.
          ? const Home()
          : Scaffold(
              appBar: AppBar(title: const Text('verify email first please')),
            );
}
