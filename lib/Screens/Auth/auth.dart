// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:firebasetest/Screens/Auth/signin.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SignIn());
  }
}
