// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/report_controller.dart';
import '../../controllers/user_controller.dart';

class CoordinatorReportWebView extends StatefulWidget {
  const CoordinatorReportWebView({super.key});

  @override
  _CoordinatorReportWebViewState createState() =>
      _CoordinatorReportWebViewState();
}

class _CoordinatorReportWebViewState extends State<CoordinatorReportWebView> {
  final ReportController _reportController = Get.find();
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Obx(() {
        if (_reportController.reports.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Material(
                child: ListView.builder(
                  itemCount: _reportController.reports.length,
                  itemBuilder: (context, index) {
                    final report = _reportController.reports[index];
                    final supportUser = _userController.user
                        .firstWhere((user) => user.id == report.userId);
                    return ListTile(
                      title: Text('Support: ${supportUser.name}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Duration: ${report.duration} minutes'),
                          Text(
                              'Start Date: ${report.startDate.toString().padLeft(2, '0')}:00'),
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
                              color: Colors.blueGrey[800],
                            ),
                            onPressed: () async {
                              setState(() {
                                _reportController.reports[index].rating =
                                    starIndex + 1;
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
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
