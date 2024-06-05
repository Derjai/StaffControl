import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:remote_staff_control/domain/model/client.dart';
import 'package:remote_staff_control/domain/use_case/client_usecase.dart';
import 'package:remote_staff_control/ui/controllers/client_controller.dart';
import 'client_usecase_mock.dart';

void main() {
  late MockClientUseCase mockClientUseCase;
  late ClientController clientController;

  setUp(() {
    mockClientUseCase = MockClientUseCase();
    Get.put<ClientUseCase>(mockClientUseCase); // Registrar el mock en GetX
    clientController = ClientController();
  });

  test('initial clients list should be empty', () {
    expect(clientController.clients, isEmpty);
  });

  test('getClients should fetch clients from use case', () async {
    final clientsList = [Client(id: 1, Name: 'Client 1')];
    when(mockClientUseCase.getClients()).thenAnswer((_) async => clientsList);

    await clientController.getClients();

    expect(clientController.clients, clientsList);
    verify(mockClientUseCase.getClients()).called(1);
  });

  test('addClient should call use case and refresh clients list', () async {
    final client = Client(id: 2, Name: 'Client 2');
    final clientsList = [client];
    when(mockClientUseCase.getClients()).thenAnswer((_) async => clientsList);

    await clientController.addClient(client);

    verify(mockClientUseCase.addClient(client)).called(1);
    verify(mockClientUseCase.getClients()).called(1);
    expect(clientController.clients, clientsList);
  });

  test('updateClient should call use case and refresh clients list', () async {
    final client = Client(id: 1, Name: 'Updated Client');
    final clientsList = [client];
    when(mockClientUseCase.getClients()).thenAnswer((_) async => clientsList);

    await clientController.updateClient(client);

    verify(mockClientUseCase.updateClient(client)).called(1);
    verify(mockClientUseCase.getClients()).called(1);
    expect(clientController.clients, clientsList);
  });

  test('deleteClient should call use case and refresh clients list', () async {
    const clientId = 1;
    when(mockClientUseCase.getClients()).thenAnswer((_) async => []);

    await clientController.deleteClient(clientId);

    verify(mockClientUseCase.deleteClient(clientId)).called(1);
    verify(mockClientUseCase.getClients()).called(1);
    expect(clientController.clients, isEmpty);
  });
}
