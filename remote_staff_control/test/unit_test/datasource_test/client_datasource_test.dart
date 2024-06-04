import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:remote_staff_control/data/datasources/remote/client_datasource.dart';
import 'package:remote_staff_control/domain/model/client.dart';

void main() {
  late ClientDataSource dataSource;
  late http.Client httpClient;
  late Client newClient;

  setUp(() {
    httpClient = http.Client();
    dataSource = ClientDataSource(client: httpClient);
    newClient = Client(
      id: 1000,
      Name: 'Test',
    );
  });

  tearDown(() async {
    await dataSource.deleteClient(newClient.id!);
    httpClient.close();
  });

  test('addClient adds a client', () async {
    bool result = await dataSource.addClient(newClient);
    expect(result, true, reason: 'Client was not added');
  });

  test('updateClient updates a client', () async {
    await dataSource.addClient(newClient);
    List<Client> clients = await dataSource.getClients();
    Client? createdClient =
        clients.firstWhereOrNull((client) => client.Name == newClient.Name);
    expect(createdClient, isNotNull,
        reason: 'Client was not created therefore not found');

    createdClient!.Name = 'Updated';
    bool updateResult = await dataSource.updateClient(createdClient);
    expect(updateResult, isTrue, reason: 'Client was not updated');
  });

  test('deleteClient deletes a client', () async {
    await dataSource.addClient(newClient);
    List<Client> clients = await dataSource.getClients();
    Client? createdClient =
        clients.firstWhereOrNull((client) => client.id == newClient.id);
    expect(createdClient, isNotNull,
        reason: 'Client was not created therefore not found');

    bool deleteResult = await dataSource.deleteClient(createdClient!.id!);
    expect(deleteResult, isTrue, reason: 'Client was not deleted');
  });
}
