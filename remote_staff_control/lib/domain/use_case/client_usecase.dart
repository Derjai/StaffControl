import 'package:remote_staff_control/domain/repositories/i_client_repository.dart';

import '../model/client.dart';

class ClientUseCase {
  final IClientRepository _clientRepository;
  ClientUseCase(this._clientRepository);

  Future<List<Client>> getClients() async =>
      await _clientRepository.getClients();
  Future<bool> addClient(Client client) async =>
      await _clientRepository.addClient(client);
  Future<bool> updateClient(Client client) async =>
      await _clientRepository.updateClient(client);
  Future<bool> deleteClient(int id) async =>
      await _clientRepository.deleteClient(id);
}
