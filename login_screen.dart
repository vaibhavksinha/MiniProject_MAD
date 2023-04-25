import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecttest/firebase_services.dart';
import 'package:projecttest/signUp.dart';

import 'constants.dart';
import 'main.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _emailController;
    _passwordController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                " Login to See Visualization",
                style: AppBarFont,
              ),
            ),
            ClipRRect(
              child: Image.network(
                "https://cdn.vectorstock.com/i/preview-2x/11/80/bear-bull-market-investment-exchange-finance-vector-37641180.webp",
                height: _size.height * 0.2,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                width: _size.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: _size.width * 0.8,
                        child: Text(
                          "Email",
                          style: style1,
                        )),
                    TeextField.textField(
                        size: _size,
                        controller: _emailController,
                        hideText: false),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: _size.width * 0.8,
                        child: Text(
                          "Password",
                          style: style1,
                        )),
                    TeextField.textField(
                        size: _size,
                        controller: _passwordController,
                        hideText: true),
                    const SizedBox(
                      height: 20,
                    ),
                    LoginButton.loginButton(
                        size: _size,
                        onPressed: () {
                          FirebaseServices().signInwithEmailAndPassword(
                              context: context,
                              email: _emailController.text,
                              password: _passwordController.text);
                        },
                        txt: "Login"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()),
                          );
                        },
                        child: Text("Create a New Account."))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController;
    _passwordController;
    super.dispose();
  }
}

class TeextField {
  static Widget textField(
      {required Size size,
      required TextEditingController controller,
      required bool hideText}) {
    return Container(
      height: size.height * 0.05,
      width: size.width * 0.75,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          obscureText: hideText,
          controller: controller,
          decoration: const InputDecoration.collapsed(hintText: ""),
        ),
      ),
    );
  }
}

class LoginButton {
  static Widget loginButton(
      {required Size size,
      required VoidCallback onPressed,
      required String txt}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size.height * 0.05,
        width: size.width * 0.3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green.shade300,
        ),
        child: Text(
          txt,
          style: style1,
        ),
      ),
    );
  }
}
