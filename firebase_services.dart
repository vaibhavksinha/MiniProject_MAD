import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecttest/get_user_info.dart';
import 'package:projecttest/login_screen.dart';

import 'main.dart';

class FirebaseServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentuser => _firebaseAuth.currentUser;

  Stream<User?> get authstatechanges => _firebaseAuth.authStateChanges();

  Future<void> signUpwithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password).then((value) => {
              print(value),
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => GetProfileInfo(email: email,)
                ),
              )
            })
        .catchError((error) {
      print(error);
    });
  }

  Future<void> signInwithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    await _firebaseAuth
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) => {
              print(value),
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => MyHomePage(
                    title: 'Stock Prediction', email: email,
                  ),
                ),
              )
            })
        .catchError((error) {
      print(error);
    });
  }
}
