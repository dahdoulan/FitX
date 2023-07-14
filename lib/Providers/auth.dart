import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import '../Utils/Util.dart';

class AuthProvider extends ChangeNotifier {
  Future logIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Util.showSnackBar(e.message);
      print(e);
    }

    notifyListeners();
  }

  Future logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      Util.showSnackBar(e.message);
      print(e);
    }
    notifyListeners();
  }
}
