// lib/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User _user = User(name: 'John Doe', email: 'johndoe@example.com');

  User get user => _user;

  void updateUser(String name, String email) {
    _user = User(name: name, email: email);
    notifyListeners();
  }
}
