import 'package:flutter/material.dart';
import 'package:front/domain/user.dart';

class Userservice with ChangeNotifier {
  User? user;

  void clearUser() {
    user = null;
    notifyListeners();
  }
}
