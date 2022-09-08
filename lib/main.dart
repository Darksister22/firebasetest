// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:firebasetest/Screens/wrapper.dart';
import 'package:firebasetest/Services/google_sign_in.dart';
import 'package:firebasetest/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //will not render widgets until app is initialized.
  await Firebase.initializeApp(); //initialize Firebase application.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GoogleSignInProvider>(
      create: (_) => GoogleSignInProvider(),
      builder: ((context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
          //initialRoute: '/',
          // onGenerateRoute: RouteGen.generateRoute,
        );
      }),
    );
  }
}
//Navigator.of(context).pushNamed('/second',arguments:'gjgdkfgkdfjglj')