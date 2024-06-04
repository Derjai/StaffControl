import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:remote_staff_control/data/datasources/remote/user_datasource.dart';
import 'package:remote_staff_control/domain/model/user.dart';

void main() {
  late UserDataSource dataSource;
  late http.Client httpClient;
  late User newUser;

  setUp(() {
    httpClient = http.Client();
    dataSource = UserDataSource(client: httpClient);
    newUser = User(
      id: 1000,
      name: 'Test',
      email: 'example@example.com',
      password: '0000',
    );
  });

  tearDown(() async {
    await dataSource.deleteUser(newUser.id!);
    httpClient.close();
  });

  test('addUser adds a user', () async {
    bool result = await dataSource.addUser(newUser);
    expect(result, true, reason: 'User was not added');
  });

  test('updateUser updates a user', () async {
    await dataSource.addUser(newUser);
    List<User> users = await dataSource.getUsers();
    User? createdUser =
        users.firstWhereOrNull((user) => user.name == newUser.name);
    expect(createdUser, isNotNull,
        reason: 'User was not created therefore not found');

    createdUser!.name = 'Updated';
    bool updateResult = await dataSource.updateUser(createdUser);
    expect(updateResult, isTrue, reason: 'User was not updated');
  });

  test('deleteUser deletes a user', () async {
    await dataSource.addUser(newUser);
    List<User> users = await dataSource.getUsers();
    User? createdUser = users.firstWhereOrNull((user) => user.id == newUser.id);
    expect(createdUser, isNotNull,
        reason: 'User was not created therefore not found');

    bool deleteResult = await dataSource.deleteUser(createdUser!.id!);
    expect(deleteResult, isTrue, reason: 'User was not deleted');
  });
}
