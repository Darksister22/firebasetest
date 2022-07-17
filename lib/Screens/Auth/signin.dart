import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: Text('Strawberries'),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(2),
        child: TextButton(
          child: Text('Sign In Anon'),
          onPressed: () {},
        ),
      ),
    );
  }
}
