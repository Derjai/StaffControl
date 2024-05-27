import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/model/client.dart';
import '../../controllers/client_controller.dart';

class CoordinatorClientWebView extends StatelessWidget {
  final ClientController _clientController = Get.find<ClientController>();
  CoordinatorClientWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Obx(() {
                if (_clientController.clients.isEmpty) {
                  return const CircularProgressIndicator(); // Show loading indicator while waiting for data
                } else {
                  return SizedBox(
                    height: 300, // Set the height to the desired maximum
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'ID',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Name',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          // Add more DataColumn widgets here for additional columns
                        ],
                        rows: _clientController.clients.map((client) {
                          return DataRow(cells: [
                            DataCell(Text('${client.id}')),
                            DataCell(Text(client.Name)),
                            // Add more DataCell widgets here for additional cells
                          ]);
                        }).toList(),
                      ),
                    ),
                  );
                }
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String name = '';
                        return AlertDialog(
                          title: const Text('Create Client'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                onChanged: (value) {
                                  name = value;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                int id = _clientController.clients.isNotEmpty
                                    ? _clientController.clients.last.id! + 1
                                    : 1;
                                Client client = Client(id: id, Name: name);
                                await _clientController.addClient(client);
                                if (!context.mounted) return;
                                Navigator.of(context).pop();
                              },
                              child: const Text('Create'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Create',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        int id = 0;
                        String name = '';
                        return AlertDialog(
                          title: const Text('Update Client'),
                          content: Column(
                            children: <Widget>[
                              TextField(
                                onChanged: (value) {
                                  id = int.tryParse(value)!;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter client's ID",
                                ),
                              ),
                              TextField(
                                onChanged: (value) {
                                  name = value;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter new client's name",
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                Client client = Client(id: id, Name: name);
                                await _clientController.updateClient(client);
                                if (!context.mounted) return;
                                Navigator.of(context).pop();
                              },
                              child: const Text('Update'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        int id = 0;
                        return AlertDialog(
                          title: const Text('Delete Client'),
                          content: Column(
                            children: <Widget>[
                              TextField(
                                onChanged: (value) {
                                  id = int.tryParse(value)!;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter client's ID",
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                await _clientController.deleteClient(id);
                                if (!context.mounted) return;
                                Navigator.of(context).pop();
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
