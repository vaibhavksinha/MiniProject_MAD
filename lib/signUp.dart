import 'package:flutter/material.dart';
import 'package:projecttest/constants.dart';
import 'package:projecttest/firebase_services.dart';
import 'package:projecttest/login_screen.dart';







class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                " Login to See Prediction",
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
                          FirebaseServices().signUpwithEmailAndPassword(
                            context: context,
                              email: _emailController.text,
                              password: _passwordController.text);
                        },
                        txt: "Signup"),



                       
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );;
  }
}