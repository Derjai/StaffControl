// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/report_controller.dart';
import '../../controllers/user_controller.dart';

class CoordinatorWebView extends StatefulWidget {
  const CoordinatorWebView({super.key});

  @override
  _CoordinatorWebViewState createState() => _CoordinatorWebViewState();
}

class _CoordinatorWebViewState extends State<CoordinatorWebView> {
  final UserController _userController = Get.find();
  final ReportController _reportController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome Back Coordinator!'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        ),
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          UserAccountsDrawerHeader(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
            accountName: const Text('Navigation Menu'),
            accountEmail: null,
            currentAccountPicture: null,
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Manage Clients'),
            onTap: () {
              Navigator.pushNamed(context, '/coordinator/clients');
            },
          ),
          ListTile(
            leading: const Icon(Icons.support_agent),
            title: const Text('Manage Support Users'),
            onTap: () {
              Navigator.pushNamed(context, '/coordinator/us');
            },
          ),
          ListTile(
            leading: const Icon(Icons.reviews),
            title: const Text('Rate Reports'),
            onTap: () {
              Navigator.pushNamed(context, '/coordinator/reports');
            },
          ),
        ])),
        body: Center(
          child: Obx(() {
            final unRatedReports = _reportController.reports
                .where((report) => report.rating == 0)
                .toList();

            if (_reportController.reports.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else if (unRatedReports.isEmpty) {
              return const Text('All reports are up to date');
            } else {
              return ListView.builder(
                itemCount: unRatedReports.length,
                itemBuilder: (context, index) {
                  final report = unRatedReports[index];
                  final supportUser = _userController.user.firstWhere((user) =>
                      user.id ==
                      report
                          .userId); // Asegúrate de que 'supportId' es el campo correcto para el ID del soporte
                  return ListTile(
                    title: Text(
                        'Support: ${supportUser.name}'), // Ahora se muestra el nombre del usuario de soporte
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Duration: ${report.duration} minutes'),
                        Text(
                            'Start Date: ${report.startDate.toString().padLeft(2, '0')}:00'), // Asume que Start Date es un entero que representa la hora
                        const Text('Problem Description:'),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(report.problemDescription),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        5,
                        (starIndex) => IconButton(
                          icon: Icon(
                            starIndex < report.rating
                                ? Icons.star
                                : Icons.star_border,
                          ),
                          onPressed: () async {
                            setState(() {
                              report.rating = starIndex + 1;
                            });
                            int id = report.id!;
                            await _reportController.patchReport(
                                id, starIndex + 1);
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
        ));
  }
}
