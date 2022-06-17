import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class AuthService {
  var auth = FirebaseAuth.instance;

  Future signIn(BuildContext context, String email, String password) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 1000),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text(
                "Authenticating. Please wait .....",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          backgroundColor: primaryColor,
        ),
      );
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(auth.currentUser);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Failed to Login!",
            textAlign: TextAlign.center,
          ),
          backgroundColor: redColor,
        ),
      );
      print(e);
    }
  }

  Future createUser(String email, String pass) async {
    await auth.createUserWithEmailAndPassword(email: email, password: pass);
  }

  Future signOut() async {
    await auth.signOut();
  }
}
