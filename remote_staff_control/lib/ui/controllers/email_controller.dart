import 'package:flutter/material.dart';

class EmailController extends TextEditingController {
  bool isValidEmail() {
    final String email = text;
    final RegExp regex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return regex.hasMatch(email);
  }

  void clearText() {
    clear();
  }
}
