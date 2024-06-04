import 'package:flutter_test/flutter_test.dart';
import 'package:remote_staff_control/data/datasources/remote/client_datasource.dart';
import 'package:remote_staff_control/data/datasources/remote/report_datasource.dart';
import 'package:remote_staff_control/data/datasources/remote/user_datasource.dart';
import 'package:remote_staff_control/data/repositories/repository.dart';
import 'package:remote_staff_control/domain/model/report.dart';
import 'package:remote_staff_control/domain/model/user.dart';
import 'package:remote_staff_control/domain/model/client.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'mocks/repository_test.mocks.dart';

@GenerateMocks([ClientDataSource, ReportDataSource, UserDataSource])
void main() {
  var mockClientDataSource = MockClientDataSource();
  var mockReportDataSource = MockReportDataSource();
  var mockUserDataSource = MockUserDataSource();
  late ClientRepository clientRepository;
  late ReportRepository reportRepository;
  late UserRepository userRepository;
  late Client newClient;
  late Report newReport;
  late User newUser;

  setUp(() {
    clientRepository = ClientRepository(mockClientDataSource);
    reportRepository = ReportRepository(mockReportDataSource);
    userRepository = UserRepository(mockUserDataSource);

    newClient = Client(
      id: 1000,
      Name: 'Test Client',
    );
    newUser = User(
      id: 1000,
      name: 'Test User',
      email: 'example@gmail.com',
      password: '000',
    );
    newReport = Report(
      id: 1000,
      userId: 1,
      startDate: 1,
      duration: 1,
      problemDescription: 'Test Report',
      rating: 0,
    );
    when(mockClientDataSource.addClient(any)).thenAnswer((_) async => true);
    when(mockClientDataSource.updateClient(any)).thenAnswer((_) async => true);
    when(mockClientDataSource.deleteClient(any)).thenAnswer((_) async => true);
    when(mockUserDataSource.addUser(any)).thenAnswer((_) async => true);
    when(mockUserDataSource.updateUser(any)).thenAnswer((_) async => true);
    when(mockUserDataSource.deleteUser(any)).thenAnswer((_) async => true);
    when(mockReportDataSource.addReport(any)).thenAnswer((_) async => true);
    when(mockReportDataSource.updateReport(any)).thenAnswer((_) async => true);
    when(mockReportDataSource.deleteReport(any)).thenAnswer((_) async => true);
  });

  test('addClient adds a client', () async {
    bool result = await clientRepository.addClient(newClient);
    expect(result, true);
    verify(mockClientDataSource.addClient(newClient)).called(1);
  });

  test('updateClient updates a client', () async {
    bool result = await clientRepository.updateClient(newClient);
    expect(result, true);
    verify(mockClientDataSource.updateClient(newClient)).called(1);
  });

  test('deleteClient deletes a client', () async {
    bool result = await clientRepository.deleteClient(1000);
    expect(result, true);
    verify(mockClientDataSource.deleteClient(1000)).called(1);
  });

  test('addUser adds a user', () async {
    bool result = await userRepository.addUser(newUser);
    expect(result, true);
    verify(mockUserDataSource.addUser(newUser)).called(1);
  });

  test('updateUser updates a user', () async {
    bool result = await userRepository.updateUser(newUser);
    expect(result, true);
    verify(mockUserDataSource.updateUser(newUser)).called(1);
  });

  test('deleteUser deletes a user', () async {
    bool result = await userRepository.deleteUser(1000);
    expect(result, true);
    verify(mockUserDataSource.deleteUser(1000)).called(1);
  });

  test('addReport adds a report', () async {
    bool result = await reportRepository.addReport(newReport);
    expect(result, true);
    verify(mockReportDataSource.addReport(newReport)).called(1);
  });

  test('updateReport updates a report', () async {
    bool result = await reportRepository.updateReport(newReport);
    expect(result, true);
    verify(mockReportDataSource.updateReport(newReport)).called(1);
  });

  test('deleteReport deletes a report', () async {
    bool result = await reportRepository.deleteReport(1000);
    expect(result, true);
    verify(mockReportDataSource.deleteReport(1000)).called(1);
  });
}
