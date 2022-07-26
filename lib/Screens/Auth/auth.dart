// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:firebasetest/Screens/Auth/register.dart';
import 'package:firebasetest/Screens/Auth/signin.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool signedIn = true;
  void toggle() {
    setState(() {
      signedIn = !signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (signedIn) {
      return SafeArea(
          child: SignIn(
        toggle: toggle,
      ));
    } else {
      return SafeArea(
          child: Register(
        toggle: toggle,
      ));
    }
  }
}
