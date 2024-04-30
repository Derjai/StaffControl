// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CoordinatorReportWebView extends StatefulWidget {
  const CoordinatorReportWebView({super.key});

  @override
  _CoordinatorReportWebViewState createState() =>
      _CoordinatorReportWebViewState();
}

class _CoordinatorReportWebViewState extends State<CoordinatorReportWebView> {
  List<Map<String, dynamic>> _reports = [
    {
      'ID': '1',
      'Client': 'Juan',
      'Start Date': '09:00',
      'Duration': '60',
      'Rating': 0,
      'Problem Description': 'Computer not turning on'
    },
    {
      'ID': '2',
      'Client': 'María',
      'Start Date': '10:00',
      'Duration': '45',
      'Rating': 0,
      'Problem Description': 'Internet connection issues'
    },
    {
      'ID': '3',
      'Client': 'Pedro',
      'Start Date': '11:00',
      'Duration': '30',
      'Rating': 0,
      'Problem Description': 'Printer not working'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.lightBlueAccent),
              columns: <DataColumn>[
                const DataColumn(
                  label:
                      Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const DataColumn(
                  label: Text('Client',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const DataColumn(
                  label: Text('Start Date',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const DataColumn(
                  label: Text('Duration (min)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const DataColumn(
                  label: Text('Problem Description',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const DataColumn(
                  label: Text('Rating',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
              rows: _reports
                  .map(
                    (report) => DataRow(
                      cells: [
                        DataCell(
                          Text(report['ID']),
                          showEditIcon: false,
                        ),
                        DataCell(
                          Text(report['Client']),
                          showEditIcon: false,
                        ),
                        DataCell(
                          Text(report['Start Date']),
                          showEditIcon: false,
                        ),
                        DataCell(
                          Text(report['Duration']),
                          showEditIcon: false,
                        ),
                        DataCell(
                          Text(report['Problem Description']),
                          showEditIcon: false,
                        ),
                        DataCell(
                          Row(
                            children: List.generate(
                              5,
                              (index) => IconButton(
                                icon: Icon(
                                  Icons.star,
                                  color: index < report['Rating']
                                      ? Colors.orange
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _reports[_reports.indexOf(report)]
                                        ['Rating'] = index + 1;
                                  });
                                },
                              ),
                            ),
                          ),
                          showEditIcon: false,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
