import 'package:flutter/material.dart';
import 'package:remote_staff_control/ui/pages/authentication/login_screen.dart';
import 'package:remote_staff_control/ui/pages/coordinator/coordinator_client_web_view.dart';
import 'package:remote_staff_control/ui/pages/coordinator/coordinator_report_web_view.dart';
import 'package:remote_staff_control/ui/pages/coordinator/coordinator_us_web_view.dart';
import 'package:remote_staff_control/ui/pages/support/support_mobile_report_view.dart';

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
        primaryColor: Colors.blueGrey[800],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey[800],
          ),
        ),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.cyan[600],
        ).copyWith(secondary: Colors.cyan[600]),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/coordinator': (context) => const CoordinatorWebView(),
        '/coordinator/us': (context) => const CoordinatorUsWebView(),
        '/coordinator/reports': (context) => const CoordinatorReportWebView(),
        '/coordinator/clients': (context) => const CoordinatorClientWebView(),
        '/support': (context) => const SupportMobileView(),
        '/support/reports': (context) => const SupportMobileReportView(),
      },
    );
  }
}
