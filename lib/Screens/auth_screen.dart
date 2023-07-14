import 'package:fitx_flutter_2/Screens/login_screen.dart';
import 'package:fitx_flutter_2/Screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) return MainScreen();
            return LogIn();
          }),
    );
  }
}
