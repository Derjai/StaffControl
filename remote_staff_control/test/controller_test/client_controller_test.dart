import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remote_staff_control/domain/model/client.dart';
import 'package:remote_staff_control/domain/use_case/client_usecase.dart';
import 'package:remote_staff_control/ui/controllers/client_controller.dart';
import '../unit_test/mocks/client_controller_test.mocks.dart';

@GenerateMocks([ClientUseCase])
void main() {
  late MockClientUseCase mockClientUseCase;
  late ClientController clientController;

  setUp(() {
    mockClientUseCase = MockClientUseCase();
    Get.put<ClientUseCase>(mockClientUseCase);
    clientController = ClientController();
  });

  tearDown(() {
    Get.reset();
  });

  test('getClients should fetch clients from use case', () async {
    when(mockClientUseCase.getClients())
        .thenAnswer((_) async => [Client(id: 1, Name: 'Test Client')]);

    await clientController.getClients();

    expect(clientController.clients, isNotEmpty);
    expect(clientController.clients.first.Name, 'Test Client');
  });

  test('addClient should call use case and refresh clients list', () async {
    var newClient = Client(id: 2, Name: 'New Client');
    when(mockClientUseCase.addClient(newClient)).thenAnswer((_) async => true);
    when(mockClientUseCase.getClients()).thenAnswer((_) async => [newClient]);

    await clientController.addClient(newClient);

    verify(mockClientUseCase.addClient(newClient)).called(1);
    verify(mockClientUseCase.getClients()).called(1);
  });

  test('updateClient should call use case and refresh clients list', () async {
    final client = Client(id: 1, Name: 'Test Client');
    final updatedClient = Client(id: client.id, Name: 'Updated Client');
    when(mockClientUseCase.addClient(client)).thenAnswer((_) async => true);
    when(mockClientUseCase.updateClient(updatedClient))
        .thenAnswer((_) async => true);
    when(mockClientUseCase.getClients())
        .thenAnswer((_) async => [updatedClient]);

    await clientController.addClient(client);
    await clientController.updateClient(updatedClient);

    verify(mockClientUseCase.updateClient(updatedClient)).called(1);
    verify(mockClientUseCase.getClients()).called(2);
    expect(clientController.clients, isNotEmpty);
    expect(clientController.clients.first.Name, 'Updated Client');
  });

  test('deleteClient should call use case and refresh clients list', () async {
    final client = Client(id: 1, Name: 'Test Client');
    when(mockClientUseCase.addClient(client)).thenAnswer((_) async => true);
    when(mockClientUseCase.deleteClient(client.id!))
        .thenAnswer((_) async => true);
    when(mockClientUseCase.getClients()).thenAnswer((_) async => []);

    await clientController.addClient(client);
    await clientController.deleteClient(client.id!);

    verify(mockClientUseCase.deleteClient(client.id!)).called(1);
    verify(mockClientUseCase.getClients()).called(2);
    expect(clientController.clients, isEmpty);
  });
}
