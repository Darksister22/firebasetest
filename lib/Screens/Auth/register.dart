import 'package:firebasetest/Services/fireauth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggle;
  const Register({Key? key, required this.toggle}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = '';

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
            label: const Text('Sign In'),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            icon: const Icon(Icons.login),
          )
        ],
        backgroundColor: Colors.pink[300],
        title: Text('Register to Strawberries'),
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
                    controller: password,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter a password';
                      } else if (val.length < 6) {
                        return 'Password must be longer than 6 characters';
                      }
                      return null;
                    },
                    obscureText: true,
                    onChanged: (val) {},
                  ),
                  Divider(
                    height: 20,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              child: Text('Register'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  dynamic result =
                      _auth.registerEmail(email.text, password.text);
                  if (result == null) {
                    setState(() {
                      error = 'please enter a valid email!';
                    });
                  }
                }
              },
            ),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
