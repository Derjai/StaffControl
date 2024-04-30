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

  tearDown(() {
    httpClient.close();
  });

  test('Create, Retrieve, Update, and Delete an entry', () async {
    bool createResult = await dataSource.addClient(newClient);
    expect(createResult, true);

    List<Client> clients = await dataSource.getClients();
    Client? createdClient =
        clients.firstWhereOrNull((client) => client.Name == newClient.Name);
    expect(createdClient, isNotNull);

    createdClient!.Name = 'Updated';
    bool updateResult = await dataSource.updateClient(createdClient);
    print('updateResult: $updateResult');
    expect(updateResult, isTrue);
    print('deleteUser: ${createdClient.id}');
    bool deleteResult = await dataSource.deleteClient(createdClient!.id!);
    expect(deleteResult, isTrue);
  });
}
