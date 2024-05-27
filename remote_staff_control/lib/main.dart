import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_staff_control/data/datasources/remote/user_datasource.dart';
import 'package:remote_staff_control/data/datasources/remote/client_datasource.dart';
import 'package:remote_staff_control/data/datasources/remote/i_client_datasource.dart';
import 'package:remote_staff_control/domain/repositories/i_client_repository.dart';
import 'package:remote_staff_control/domain/repositories/i_user_repository.dart';
import 'package:remote_staff_control/domain/use_case/client_usecase.dart';
import 'package:remote_staff_control/domain/use_case/report_usecase.dart';
import 'package:remote_staff_control/domain/use_case/user_usecase.dart';
import 'package:remote_staff_control/ui/controllers/auth_controller.dart';
import 'package:remote_staff_control/ui/controllers/email_controller.dart';
import 'package:remote_staff_control/ui/controllers/user_controller.dart';
import 'package:remote_staff_control/ui/pages/authentication/login_screen.dart';
import 'package:remote_staff_control/ui/pages/coordinator/coordinator_client_web_view.dart';
import 'package:remote_staff_control/ui/pages/coordinator/coordinator_report_web_view.dart';
import 'package:remote_staff_control/ui/pages/coordinator/coordinator_us_web_view.dart';
import 'package:remote_staff_control/ui/pages/support/support_mobile_report_view.dart';

import 'data/datasources/remote/i_report_datasource.dart';
import 'data/datasources/remote/i_user_datasource.dart';
import 'data/datasources/remote/report_datasource.dart';
import 'data/repositories/repository.dart';
import 'domain/repositories/i_report_repository.dart';
import 'ui/controllers/client_controller.dart';
import 'ui/controllers/password_controller.dart';
import 'ui/controllers/report_controller.dart';
import 'ui/pages/coordinator/coordinator_web_view.dart';
import 'ui/pages/support/support_mobile_view.dart';

void main() {
  Get.put<IClientDataSource>(ClientDataSource());
  Get.put<IUserDatasource>(UserDataSource());
  Get.put<IReportDataSource>(ReportDataSource());
  Get.put<IClientRepository>(ClientRepository(Get.find<IClientDataSource>()));
  Get.put<IUserRepository>(UserRepositoty(Get.find<IUserDatasource>()));
  Get.put<IReportRepository>(ReportRepository(Get.find<IReportDataSource>()));
  Get.put(ClientUseCase(Get.find<IClientRepository>()));
  Get.put(UserUseCase(Get.find<IUserRepository>()));
  Get.put(ReportUseCase(Get.find<IReportRepository>()));
  Get.put(EmailController());
  Get.put(PasswordController());
  Get.put(AuthController(
      emailController: Get.find(), passwordController: Get.find()));
  Get.put(ClientController());
  Get.put(UserController());
  Get.put(ReportController());
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
        '/coordinator/us': (context) => CoordinatorUsWebView(),
        '/coordinator/reports': (context) => const CoordinatorReportWebView(),
        '/coordinator/clients': (context) => CoordinatorClientWebView(),
        '/support': (context) => SupportMobileView(),
        '/support/reports': (context) => SupportMobileReportView(),
      },
    );
  }
}
