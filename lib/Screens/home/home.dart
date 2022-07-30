// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/Services/fireauth.dart';
import 'package:firebasetest/Services/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[100],
        appBar: AppBar(
          backgroundColor: Colors.pink[500],
          title: const Text('Home'),
          actions: [
            TextButton.icon(
              onPressed: () async {
                final provider = Provider.of<GoogleSignInProvider>(context,
                    listen: false); //creating an instance of the class here.
                await provider.googleLogout();
              },
              label: const Text('Logout'),
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.photoURL ??
                    'https://media.istockphoto.com/vectors/unknown-person-female-vector-id1345610707'),
              ),
              Text(
                'Name: ' + (user.displayName ?? ' لا يوجد'),
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                'Email: ' + (user.email ?? ' لا يوجد'),
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ));
  }
}
