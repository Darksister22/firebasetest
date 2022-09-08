import 'package:firebasetest/Screens/home/home.dart';
import 'package:flutter/material.dart';

class RouteGen {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args =
        settings.arguments; //getting the arguments passed in pushnamed.

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/seconds':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => Home(/*args*/));
        }
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return MaterialPageRoute(builder: (_) => Home());
    }
  }
}
