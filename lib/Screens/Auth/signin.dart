// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/Services/fireauth.dart';
import 'package:firebasetest/Services/google_sign_in.dart';
import 'package:firebasetest/shared/constants.dart';
import 'package:firebasetest/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({Key? key, required this.toggle}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  TextEditingController email = TextEditingController();
  bool loading = false;

  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  FirebaseAuth _phoneauth = FirebaseAuth.instance;
  TextEditingController phone = TextEditingController();
  TextEditingController otp = TextEditingController();
  bool logged = false;
  String verId = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.pink[100],
            appBar: AppBar(
              actions: [
                TextButton.icon(
                  onPressed: () async {
                    widget.toggle();
                  },
                  label: const Text('Register'),
                  style: TextButton.styleFrom(
                      textStyle: TextStyle(color: Colors.white)),
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
                          decoration:
                              inputDecor.copyWith(labelText: 'Password'),
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
                        style: ElevatedButton.styleFrom(primary: Colors.pink),
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
                            primary: Colors.pinkAccent),
                        child: Text('Log In'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth.loginEmail(
                                email.text, password.text);
                            if (result != 'successful') {
                              setState(() {
                                loading = false;
                                error = 'Email or password are incorrect';
                              });
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen:
                              false); //creating an instance of the class here.
                      await provider.googleLogin();
                      setState(() {
                        loading = false;
                      });
                    },
                    label: Text('Sign-Up with Google'),
                    icon: FaIcon(FontAwesomeIcons.google),
                    style: ElevatedButton.styleFrom(primary: Colors.pink[700]),
                  ),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () async {
                        await _auth.resetPassword(email: email.text);
                      },
                      child: Text(
                        'forgot password?',
                        style: TextStyle(color: Colors.pink),
                      ))
                ],
              ),
            ),
          );

    // return Column(children: [
    //   TextField(
    //     decoration: InputDecoration(
    //       labelText: 'phone',
    //     ),
    //     controller: phone,
    //     keyboardType: TextInputType.phone,
    //   ),
    //   SizedBox(
    //     height: 10,
    //   ),
    //   Visibility(
    //     visible: logged,
    //     child: TextField(
    //       decoration: InputDecoration(labelText: 'code'),
    //       controller: otp,
    //     ),
    //   ),
    //   SizedBox(
    //     height: 10,
    //   ),
    //   ElevatedButton(
    //       onPressed: () {
    //         if (logged) {
    //           verifyCode();
    //         } else {
    //           verify();
    //         }
    //       },
    //       child: Text('login'))
    // ]);
  }

  // void verify() {
  //   _phoneauth.verifyPhoneNumber(
  //     phoneNumber: phone.text,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       //get the credentials, then sign in.
  //       await _phoneauth
  //           .signInWithCredential(credential)
  //           .then((value) => print('logged in successfully.'));
  //     },
  //     verificationFailed: (FirebaseAuthException exception) {
  //       print(exception.message);
  //     },
  //     codeSent: ((verificationId, forceResendingToken) {
  //       //what will happen when the code is sent.
  //       verId = verificationId;
  //       setState(() {
  //         logged = true;
  //       });
  //     }),
  //     codeAutoRetrievalTimeout: ((verificationId) {}),
  //   );
  // }

  // void verifyCode() async {
  //   PhoneAuthCredential credential =
  //       PhoneAuthProvider.credential(verificationId: verId, smsCode: otp.text);
  //   await _phoneauth
  //       .signInWithCredential(credential)
  //       .then((value) => print('logged in'));
  // }
}
