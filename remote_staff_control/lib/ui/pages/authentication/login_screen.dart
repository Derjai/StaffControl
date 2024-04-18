import 'package:flutter/material.dart';

//import '../../controllers/email_controller.dart';
//import '../../controllers/password_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    // TODO: Implement validations
    //final EmailController emailController = EmailController();
    //final PasswordController passwordController = PasswordController();

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
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                        ),
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 20),
                      TextField(
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
                      const SizedBox(
                          height: 20), // Más espacio entre los campos
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/coordinator');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(fontSize: 24),
                        ),
                        child: const Text('Login'),
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
                    const SizedBox(
                      width: 300, // Define the width of the TextField
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 300, // Define the width of the TextField
                      child: TextField(
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/support');
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
