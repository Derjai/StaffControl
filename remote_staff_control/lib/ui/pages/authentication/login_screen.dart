import 'dart:async';
import 'package:flutter/material.dart';
import 'package:remote_staff_control/ui/controllers/auth_controller.dart';
import '../../controllers/email_controller.dart';
import '../../controllers/password_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  final AuthController authController = AuthController(
    emailController: EmailController(),
    passwordController: PasswordController(),
  );

  @override
  void dispose() {
    authController.emailController.dispose();
    authController.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 600) {
              // Web view
              return Center(
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: authController.emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                        ),
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: authController.passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                        ),
                        obscureText: obscureText,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Hardcoded users a@a.com and b@a.com with password 0000
                          Completer completer = Completer();
                          String email = authController.emailController.text;
                          String password =
                              authController.passwordController.text;
                          bool result = email == 'a@a.com' ||
                              email == 'b@a.com' && password == '0000';
                          if (result) {
                            completer.complete();
                          }
                          completer.future.then((_) {
                            Navigator.pushNamed(context, '/coordinator');
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(fontSize: 24),
                        ),
                        child: const Text('Login',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              // Mobile view
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: authController.emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: authController.passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                        ),
                        obscureText: obscureText,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        Completer completer = Completer();
                        bool result =
                            await authController.authenticate(context);
                        if (result) {
                          completer.complete();
                        }
                        completer.future.then((_) {
                          Navigator.pushNamed(context, '/support');
                        });
                      },
                      child: const Text('Login',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
