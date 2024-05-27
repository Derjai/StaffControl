import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_staff_control/domain/model/report.dart';
import '../../controllers/report_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupportMobileView extends StatelessWidget {
  final problemDescriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final durationController = TextEditingController();

  final ReportController _reportController = Get.find();
  SupportMobileView({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
        future: getUserId(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final userId = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Welcome Back Support!'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                body: Obx(() {
                  final userReports = _reportController.reports
                      .where((report) => report.userId == userId)
                      .toList();
                  if (_reportController.reports.isEmpty ||
                      userReports.isEmpty) {
                    return const Center(
                      child: Text('No reports found'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: userReports.length,
                      itemBuilder: (context, index) {
                        final report = userReports[index];
                        return ListTile(
                          title: Text('Report ${index + 1}'),
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
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Edit Report'),
                                          content: Column(
                                            children: [
                                              TextField(
                                                controller: durationController,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Duration',
                                                ),
                                              ),
                                              TextField(
                                                controller: startDateController,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Start Date',
                                                ),
                                              ),
                                              TextField(
                                                controller:
                                                    problemDescriptionController,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText:
                                                      'Problem Description',
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                int id = report.id!;
                                                int userId = report.userId;
                                                int duration = int.tryParse(
                                                    durationController.text)!;
                                                int startDate = int.tryParse(
                                                    startDateController.text)!;
                                                String problemDescription =
                                                    problemDescriptionController
                                                        .text;
                                                Report updatedReport = Report(
                                                    id: id,
                                                    userId: userId,
                                                    duration: duration,
                                                    startDate: startDate,
                                                    problemDescription:
                                                        problemDescription,
                                                    rating: 0);
                                                await _reportController
                                                    .updateReport(
                                                        updatedReport);
                                                if (!context.mounted) return;
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Save'),
                                            ),
                                          ],
                                        );
                                      });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Delete Report'),
                                        content: const Text(
                                            'Are you sure you want to delete this report?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await _reportController
                                                  .deleteReport(report.id!);
                                              if (!context.mounted) return;
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/support/reports');
                  },
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: const Icon(Icons.add),
                ));
          }
        });
  }
}

Future<int> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userId') ?? 0; // Returns 0 if 'userId' is not set
}
