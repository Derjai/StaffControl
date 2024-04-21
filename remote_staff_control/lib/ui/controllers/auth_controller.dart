import 'dart:convert';
import 'package:flutter/material.dart';
import 'email_controller.dart';
import 'password_controller.dart';
import 'package:http/http.dart' as http;

class AuthController {
  final EmailController emailController;
  final PasswordController passwordController;

  AuthController(
      {required this.emailController, required this.passwordController});

  Future<bool> authenticate(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    // Hardcoded users a@a.com and b@b.com with password 0000

    // Validate email and password fields
    if (email.isEmpty || password.isEmpty) {
      const snackBar =
          SnackBar(content: Text('Please enter both email and password'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }

    if (!emailController.isValidEmail()) {
      const snackBar = SnackBar(content: Text('Please enter a valid email'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }

    if (!passwordController.passLength()) {
      const snackBar = SnackBar(
          content: Text('Password must be at least 4 characters long'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }

    // Support users, data from retoolapi.dev the link should be changed after 30 days of no use
    final response =
        await http.get(Uri.parse('https://retoolapi.dev/GycAyT/support'));
    if (response.statusCode == 200) {
      final List<dynamic> users = jsonDecode(response.body);
      for (var user in users) {
        if (user['email'] == email && user['password'].toString() == password) {
          return true;
        }
      }
    }

    // If no user is found and also not a coordinator
    return false;
  }
}
