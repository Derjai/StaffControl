// ignore_for_file: avoid_print

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

  tearDown(() {
    httpClient.close();
  });

  test('Create, Retrieve, Update, and Delete an entry', () async {
    bool createResult = await dataSource.addUser(newUser);
    expect(createResult, true);

    List<User> users = await dataSource.getUsers();
    User? createdUser =
        users.firstWhereOrNull((user) => user.name == newUser.name);
    expect(createdUser, isNotNull);

    createdUser!.name = 'Updated';
    bool updateResult = await dataSource.updateUser(createdUser);
    print('updateResult: $updateResult');
    expect(updateResult, isTrue);
    print('deleteUser: ${createdUser.id}');
    bool deleteResult = await dataSource.deleteUser(createdUser.id!);
    expect(deleteResult, isTrue);
  });
}
