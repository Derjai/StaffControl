import 'email_controller.dart';
import 'password_controller.dart';

class AuthController {
  final EmailController emailController;
  final PasswordController passwordController;

  AuthController(
      {required this.emailController, required this.passwordController});

  Future<bool> authenticate() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    // TODO: Login Authentication logic
    // Simulated delay of 1 second
    await Future.delayed(Duration(seconds: 1));

    // Simulated authentication
    return emailController.isValidEmail() && passwordController.passLength();
  }
}
