import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:remote_staff_control/domain/model/client.dart';

import '../../domain/use_case/client_usecase.dart';

class ClientController extends GetxController {
  final RxList<Client> _clients = <Client>[].obs;
  final ClientUseCase _clientUseCase = Get.find();

  List<Client> get clients => _clients;

  @override
  void onInit() {
    getClients();
    super.onInit();
  }

  getClients() async {
    logInfo("Getting clients");
    _clients.value = await _clientUseCase.getClients();
  }

  addClient(Client client) async {
    logInfo("Adding client");
    await _clientUseCase.addClient(client);
    logInfo("Client added successfully");
    getClients();
  }

  updateClient(Client client) async {
    logInfo("Updating client");
    await _clientUseCase.updateClient(client);
    getClients();
  }

  deleteClient(int id) async {
    logInfo("Deleting client");
    await _clientUseCase.deleteClient(id);
    getClients();
  }
}
