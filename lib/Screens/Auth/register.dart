import 'package:firebasetest/Services/fireauth.dart';
import 'package:firebasetest/shared/constants.dart';
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
        title: const Text('Register to Strawberries'),
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
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
                  const Divider(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: inputDecor.copyWith(labelText: 'Password'),
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
                  const Divider(
                    height: 20,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              child: const Text('Register'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  dynamic result;
                  result = _auth.registerEmail(email.text, password.text);
                  if (result != 'successful') {
                    setState(() {
                      error = 'Email or password are incorrect';
                    });
                  }
                }
              },
            ),
            Text(
              error,
              style: const TextStyle(color: Colors.red, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
