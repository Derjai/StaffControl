import '../model/client.dart';

abstract class IClientRepository {
  final IClientRepository _clientDataSource;

  IClientRepository(this._clientDataSource);

  Future<List<Client>> getClients();

  Future<bool> addClient(Client client);

  Future<bool> updateClient(Client client);

  Future<bool> deleteClient(int id);
}
