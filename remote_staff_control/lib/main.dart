import 'package:flutter/material.dart';
import 'package:remote_staff_control/ui/pages/authentication/login_screen.dart';

import 'ui/pages/coordinator/coordinator_web_view.dart';
import 'ui/pages/support/support_mobile_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Staff Control',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(227, 238, 212, 110)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(226, 208, 184, 87),
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/coordinator': (context) => const CoordinatorWebView(),
        '/support': (context) => const SupportMobileView(),
      },
    );
  }
}
