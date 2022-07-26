// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:firebasetest/Services/fireauth.dart';
import 'package:firebasetest/shared/constants.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({Key? key, required this.toggle}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
              widget.toggle();
            },
            label: const Text('Register'),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            icon: const Icon(Icons.app_registration),
          )
        ],
        backgroundColor: Colors.pink[300],
        title: Text('Strawberries'),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: inputDecor.copyWith(labelText: 'Email'),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter an email';
                      }
                      return null;
                    },
                    controller: email,
                    onChanged: (val) {},
                  ),
                  Divider(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: inputDecor.copyWith(labelText: 'Password'),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter a password';
                      }
                      return null;
                    },
                    controller: password,
                    obscureText: true,
                    onChanged: (val) {},
                  ),
                  Divider(
                    height: 20,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                  child: Text('Sign In Anon'),
                  onPressed: () async {
                    dynamic result = await _auth.signInAnon();
                    if (result == null) {
                      (print('error'));
                    } else {
                      print('logged in');
                      print(result.uid);
                    }
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent),
                  child: Text('Log In'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic result =
                          await _auth.loginEmail(email.text, password.text);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
