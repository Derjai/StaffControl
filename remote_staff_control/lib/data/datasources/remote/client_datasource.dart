import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loggy/loggy.dart';
import 'package:remote_staff_control/data/datasources/remote/i_client_datasource.dart';

import '../../../domain/model/client.dart';

class ClientDataSource implements IClientDataSource {
  final http.Client httpClient;
  final String apiKey = 'GcJNQQ';

  ClientDataSource({http.Client? client})
      : httpClient = client ?? http.Client();

  @override
  Future<List<Client>> getClients() async {
    List<Client> clients = [];
    var request = Uri.parse("https://retoolapi.dev/$apiKey/clients")
        .resolveUri(Uri(queryParameters: {
      "format": 'json',
    }));

    var response = await httpClient.get(request);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      clients = List<Client>.from(data.map((x) => Client.fromJson(x)));
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }
    return Future.value(clients);
  }

  @override
  Future<bool> addClient(Client client) async {
    logInfo("Adding client");
    final response = await httpClient.post(
      Uri.parse("https://retoolapi.dev/$apiKey/clients"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(client.toJson()),
    );

    if (response.statusCode == 201) {
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  @override
  Future<bool> updateClient(Client client) async {
    final response = await httpClient.put(
      Uri.parse("https://retoolapi.dev/$apiKey/clients/${client.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(client.toJson()),
    );

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  @override
  Future<bool> deleteClient(int id) async {
    final response = await httpClient.delete(
      Uri.parse("https://retoolapi.dev/$apiKey/clients/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    logInfo("Deleting client with id $id status code ${response.statusCode}");
    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }
}
