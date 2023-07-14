import 'package:flutter/material.dart';

import '../Models/user.dart';

class UserProvider extends ChangeNotifier {
  final _user = WorkoutUser();

  void setEmail(String? email) {
    _user.setEmail = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _user.setPassword = password;
    notifyListeners();
  }

  get getEmail => _user.getEmail;
  get getPassword => _user.getPassword;
}
