import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remote_staff_control/domain/model/client.dart';
import 'package:remote_staff_control/domain/repositories/i_client_repository.dart';
import 'package:remote_staff_control/domain/use_case/client_usecase.dart';
import '../mocks/client_usecase_test.mocks.dart';

@GenerateMocks([IClientRepository])
void main() {
  var mockClientRepository = MockIClientRepository();
  late ClientUseCase clientUseCase;
  late Client newClient;

  setUp(() {
    clientUseCase = ClientUseCase(mockClientRepository);
    newClient = Client(
      id: 1000,
      Name: 'Test Client',
    );
    when(mockClientRepository.addClient(any)).thenAnswer((_) async => true);
    when(mockClientRepository.updateClient(any)).thenAnswer((_) async => true);
    when(mockClientRepository.deleteClient(any)).thenAnswer((_) async => true);
  });

  test('addClient adds a client', () async {
    bool result = await clientUseCase.addClient(newClient);
    expect(result, true);
    verify(mockClientRepository.addClient(newClient));
  });

  test('updateClient updates a client', () async {
    bool result = await clientUseCase.updateClient(newClient);
    expect(result, true);
    verify(mockClientRepository.updateClient(newClient));
  });

  test('deleteClient deletes a client', () async {
    bool result = await clientUseCase.deleteClient(newClient.id!);
    expect(result, true);
    verify(mockClientRepository.deleteClient(newClient.id!));
  });
}
