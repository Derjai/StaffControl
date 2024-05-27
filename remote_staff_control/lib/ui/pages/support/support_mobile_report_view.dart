import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/model/report.dart';
import '../../controllers/report_controller.dart';

class SupportMobileReportView extends StatelessWidget {
  final problemDescriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final durationController = TextEditingController();
  final ReportController _reportController = Get.find();
  SupportMobileReportView({super.key});

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
          final cUserId = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Work Report'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20.0),
                  const Text(
                    'Problem Description',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  TextFormField(
                    controller: problemDescriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Fill the problem description here',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Start Time',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            TextFormField(
                              controller: startDateController,
                              decoration: const InputDecoration(
                                hintText: 'Enter the start time here',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.datetime,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Duration (min)',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            TextFormField(
                              controller: durationController,
                              decoration: const InputDecoration(
                                hintText: 'Enter the duration in minutes here',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      final newReportId = _reportController.reports.isNotEmpty
                          ? _reportController.reports.last.id! + 1
                          : 1;
                      const rating = 0;

                      final newReport = Report(
                        id: newReportId,
                        userId: cUserId!,
                        problemDescription: problemDescriptionController.text,
                        startDate: int.tryParse(startDateController.text)!,
                        duration: int.tryParse(durationController.text)!,
                        rating: rating,
                      );
                      await _reportController.addReport(newReport);
                      if (!context.mounted) return;
                      Navigator.pushNamed(context, '/support');
                    },
                    child: const Text('Save Report',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

Future<int> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userId') ?? 0; // Returns 0 if 'userId' is not set
}
