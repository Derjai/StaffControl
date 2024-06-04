import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remote_staff_control/ui/controllers/auth_controller.dart';
import 'package:remote_staff_control/ui/controllers/email_controller.dart';
import 'package:remote_staff_control/ui/controllers/password_controller.dart';

void main() {
  late AuthController authController;
  late EmailController emailController;
  late PasswordController passwordController;

  setUp(() {
    emailController = EmailController();
    passwordController = PasswordController();
    authController = AuthController(
      emailController: emailController,
      passwordController: passwordController,
    );
  });

  testWidgets('authenticate shows a SnackBar when email or password is empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return TextButton(
              onPressed: () async {
                authController.emailController.text = '';
                authController.passwordController.text = '';
                await authController.authenticate(context);
              },
              child: const Text('Authenticate'),
            );
          },
        ),
      ),
    ));

    await tester.tap(find.byType(TextButton));
    await tester.pump();
  });

  testWidgets(
      'authenticate shows a snackbar when password is not 3 characters long',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return TextButton(
              onPressed: () async {
                authController.emailController.text = 'example@gmail.com';
                authController.passwordController.text = '12';
                await authController.authenticate(context);
              },
              child: const Text('Authenticate'),
            );
          },
        ),
      ),
    ));
    await tester.tap(find.byType(TextButton));
    await tester.pump();
  });

  testWidgets('authenticate shows a snackbar when the email is not valid',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return TextButton(
              onPressed: () async {
                authController.emailController.text = 'example';
                authController.passwordController.text = '123';
                await authController.authenticate(context);
              },
              child: const Text('Authenticate'),
            );
          },
        ),
      ),
    ));
    await tester.tap(find.byType(TextButton));
    await tester.pump();
  });

  testWidgets('login as a coordinator user', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return TextButton(
              onPressed: () async {
                authController.emailController.text = 'a@a.com';
                authController.passwordController.text = '0000';
                await authController.authenticate(context);
              },
              child: const Text('Authenticate'),
            );
          },
        ),
      ),
    ));
    await tester.tap(find.byType(TextButton));
    await tester.pump();
  });

  testWidgets('login as a support user', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return TextButton(
              onPressed: () async {
                authController.emailController.text =
                    'clittrell5r@bigcartel.com';
                authController.passwordController.text = '843';
                await authController.authenticate(context);
              },
              child: const Text('Authenticate'),
            );
          },
        ),
      ),
    ));
    await tester.tap(find.byType(TextButton));
    await tester.pump();
  });
}
