import 'package:flutter/material.dart';

class PasswordController extends TextEditingController {
  bool passLength() {
    final String password = text;
    return password.length == 4;
  }

  void clearText() {
    clear();
  }
}
