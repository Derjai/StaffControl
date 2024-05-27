import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_staff_control/domain/model/user.dart';
import 'package:remote_staff_control/ui/controllers/user_controller.dart';

class CoordinatorUsWebView extends StatelessWidget {
  final UserController _userController = Get.find<UserController>();
  CoordinatorUsWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Users'),
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
                if (_userController.user.isEmpty) {
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
                          DataColumn(
                            label: Text(
                              'Email',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Password',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          // Add more DataColumn widgets here for additional columns
                        ],
                        rows: _userController.user.map((user) {
                          return DataRow(cells: [
                            DataCell(Text('${user.id}')),
                            DataCell(Text(user.name)),
                            DataCell(Text(user.email)),
                            DataCell(Text(user.password))
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
                        String email = '';
                        String password = '';
                        return AlertDialog(
                          title: const Text('Create User'),
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
                              TextField(
                                onChanged: (value) {
                                  email = value;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                ),
                              ),
                              TextField(
                                onChanged: (value) {
                                  password = value;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Password',
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
                                int id = _userController.user.isNotEmpty
                                    ? _userController.user.last.id! + 1
                                    : 1;
                                User user = User(
                                    id: id,
                                    name: name,
                                    email: email,
                                    password: password);
                                await _userController.addUser(user);
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
                  child: const Text('Create',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        int id = 0;
                        String name = '';
                        String email = '';
                        String password = '';
                        return AlertDialog(
                          title: const Text('Update User'),
                          content: Column(
                            children: <Widget>[
                              TextField(
                                onChanged: (value) {
                                  id = int.tryParse(value)!;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter User's ID",
                                ),
                              ),
                              TextField(
                                onChanged: (value) {
                                  name =
                                      value; // Actualiza el nombre con el valor ingresado
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter new User's name",
                                ),
                              ),
                              TextField(
                                onChanged: (value) {
                                  email = value;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter new User's email",
                                ),
                              ),
                              TextField(
                                onChanged: (value) {
                                  password = value;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter new User's password",
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                User user = User(
                                    id: id,
                                    name: name,
                                    email: email,
                                    password: password);
                                await _userController.updateUser(user);
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
                  child: const Text('Update',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        int id = 0;
                        return AlertDialog(
                          title: const Text('Delete User'),
                          content: Column(
                            children: <Widget>[
                              TextField(
                                onChanged: (value) {
                                  id = int.tryParse(value)!;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter User's ID",
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                await _userController.deleteUser(id);
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
                  child: const Text('Delete',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
