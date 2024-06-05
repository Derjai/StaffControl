import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:remote_staff_control/data/datasources/remote/client_datasource.dart';
import 'package:remote_staff_control/data/datasources/remote/i_client_datasource.dart';
import 'package:remote_staff_control/data/datasources/remote/i_report_datasource.dart';
import 'package:remote_staff_control/data/datasources/remote/i_user_datasource.dart';
import 'package:remote_staff_control/data/datasources/remote/report_datasource.dart';
import 'package:remote_staff_control/data/datasources/remote/user_datasource.dart';
import 'package:remote_staff_control/data/repositories/repository.dart';
import 'package:remote_staff_control/domain/repositories/i_client_repository.dart';
import 'package:remote_staff_control/domain/repositories/i_report_repository.dart';
import 'package:remote_staff_control/domain/repositories/i_user_repository.dart';
import 'package:remote_staff_control/domain/use_case/client_usecase.dart';
import 'package:remote_staff_control/domain/use_case/report_usecase.dart';
import 'package:remote_staff_control/domain/use_case/user_usecase.dart';
import 'package:remote_staff_control/main.dart';
import 'package:flutter/material.dart';
import 'package:remote_staff_control/ui/controllers/auth_controller.dart';
import 'package:remote_staff_control/ui/controllers/client_controller.dart';
import 'package:remote_staff_control/ui/controllers/email_controller.dart';
import 'package:remote_staff_control/ui/controllers/password_controller.dart';
import 'package:remote_staff_control/ui/controllers/report_controller.dart';
import 'package:remote_staff_control/ui/controllers/user_controller.dart';

void main() {
  setUp(() {
    Get.put<IClientDataSource>(ClientDataSource());
    Get.put<IUserDatasource>(UserDataSource());
    Get.put<IReportDataSource>(ReportDataSource());
    Get.put<IClientRepository>(ClientRepository(Get.find<IClientDataSource>()));
    Get.put<IUserRepository>(UserRepository(Get.find<IUserDatasource>()));
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
  });
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login with valid credentials, create , edit and delete a client',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final emailField = find.byType(TextField).first;
    final passwordField = find.byType(TextField).last;

    await tester.enterText(emailField, 'a@a.com');
    await tester.enterText(passwordField, '0000');

    final loginButton = find.byType(ElevatedButton);
    await tester.tap(loginButton);

    await tester.pumpAndSettle();
    expect(find.text('Welcome Back Coordinator!'), findsOneWidget);

    final drawerButton = find.byIcon(Icons.menu);
    await tester.tap(drawerButton);
    await tester.pumpAndSettle();

    final clientInterfaceListTile = find.text('Manage Clients');
    await tester.tap(clientInterfaceListTile);
    await tester.pumpAndSettle();

    expect(find.text('Clients'), findsOneWidget);

    final createButton1 = find.text('Create').first;
    await tester.tap(createButton1);
    await tester.pumpAndSettle();

    final clientNameField = find.byType(TextField).first;
    await tester.enterText(clientNameField, 'Test');

    final createButton2 = find.text('Create').last;
    await tester.tap(createButton2);
    await tester.pumpAndSettle();
    expect(find.text('Test'), findsOneWidget);

    final editButton = find.text('Update').first;
    await tester.tap(editButton);
    await tester.pumpAndSettle();

    final clientIdUpdateField = find.byType(TextField).first;
    await tester.enterText(clientIdUpdateField, 52.toString());
    final clientNameUpdateField = find.byType(TextField).last;
    await tester.enterText(clientNameUpdateField, 'Updated');

    final updateButton = find.text('Update').last;
    await tester.tap(updateButton);
    await tester.pumpAndSettle();
    expect(find.text('Updated'), findsOneWidget);

    final deleteButton = find.text('Delete').first;
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();
    final clientIdDeleteField = find.byType(TextField).first;
    await tester.enterText(clientIdDeleteField, 52.toString());
    final deleteButton2 = find.text('Delete').last;
    await tester.tap(deleteButton2);
    await tester.pumpAndSettle();
    expect(find.text('Updated'), findsNothing);
  });
}
