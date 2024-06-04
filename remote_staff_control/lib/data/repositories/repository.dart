import 'package:remote_staff_control/data/datasources/remote/i_user_datasource.dart';
import 'package:remote_staff_control/data/datasources/remote/i_report_datasource.dart';
import 'package:remote_staff_control/domain/repositories/i_user_repository.dart';

import '../../domain/model/client.dart';
import '../../domain/model/report.dart';
import '../../domain/model/user.dart';
import '../../domain/repositories/i_client_repository.dart';
import '../../domain/repositories/i_report_repository.dart';
import '../datasources/remote/i_client_datasource.dart';

class UserRepository implements IUserRepository {
  final IUserDatasource _userDataSource;
  UserRepository(this._userDataSource);

  @override
  Future<List<User>> getUsers() async => await _userDataSource.getUsers();

  @override
  Future<bool> addUser(User user) async => await _userDataSource.addUser(user);

  @override
  Future<bool> updateUser(User user) async =>
      await _userDataSource.updateUser(user);

  @override
  Future<bool> deleteUser(int id) async => await _userDataSource.deleteUser(id);
}

class ClientRepository implements IClientRepository {
  final IClientDataSource _clientDataSource;
  ClientRepository(this._clientDataSource);

  @override
  Future<List<Client>> getClients() async =>
      await _clientDataSource.getClients();

  @override
  Future<bool> addClient(Client client) async =>
      await _clientDataSource.addClient(client);

  @override
  Future<bool> updateClient(Client client) async =>
      await _clientDataSource.updateClient(client);

  @override
  Future<bool> deleteClient(int id) async =>
      await _clientDataSource.deleteClient(id);
}

class ReportRepository implements IReportRepository {
  final IReportDataSource _reportDataSource;
  ReportRepository(this._reportDataSource);

  @override
  Future<List<Report>> getReports() async =>
      await _reportDataSource.getReports();

  @override
  Future<bool> addReport(Report report) async =>
      await _reportDataSource.addReport(report);

  @override
  Future<bool> updateReport(Report report) async =>
      await _reportDataSource.updateReport(report);

  @override
  Future<bool> deleteReport(int id) async =>
      await _reportDataSource.deleteReport(id);

  @override
  Future<bool> patchReport(int reportId, int newRating) async =>
      await _reportDataSource.patchReport(reportId, newRating);
}
