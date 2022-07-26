// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:firebasetest/Services/fireauth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        backgroundColor: Colors.pink[500],
        title: const Text('Logged In.'),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _auth.logOut();
            },
            label: const Text('Logout'),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      // body: ,
    );
  }
}
