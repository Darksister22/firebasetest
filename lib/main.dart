// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:firebasetest/Screens/wrapper.dart';
import 'package:firebasetest/Services/fireauth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
              child: Container(
                  child: Text(
            'error Firebasing',
            textDirection: TextDirection.ltr,
          )));
        } else if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider.value(
            catchError: (_, __) => null,
            initialData: null,
            value: AuthService().user,
            child:
                MaterialApp(debugShowCheckedModeBanner: false, home: Wrapper()),
          );
        }
        return Container(
            child: Text(
          'Loading...',
          textDirection: TextDirection.ltr,
        ));
      },
    );
  }
}
