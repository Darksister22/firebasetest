import 'package:flutter/material.dart';

import '../home/home.dart';

class EmailVerify extends StatefulWidget {
  EmailVerify({Key? key}) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  bool isVerified = false;
  @override
  Widget build(BuildContext context) => isVerified
      ? Home()
      : Scaffold(
          appBar: AppBar(title: Text('verify email first please')),
        );
}
