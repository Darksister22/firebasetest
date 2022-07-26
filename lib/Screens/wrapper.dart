import 'package:firebasetest/Screens/home/home.dart';
import 'package:firebasetest/models/Users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Auth/auth.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
