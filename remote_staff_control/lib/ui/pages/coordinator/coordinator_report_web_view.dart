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
      'Cliente': 'Juan',
      'Hora de Inicio': '09:00',
      'Duración': '60',
      'Puntuación': 0,
      'Descripción del Problema': 'Falla en el sistema de facturación'
    },
    {
      'ID': '2',
      'Cliente': 'María',
      'Hora de Inicio': '10:00',
      'Duración': '45',
      'Puntuación': 0,
      'Descripción del Problema': 'Problemas de conexión a internet'
    },
    {
      'ID': '3',
      'Cliente': 'Pedro',
      'Hora de Inicio': '11:00',
      'Duración': '30',
      'Puntuación': 0,
      'Descripción del Problema': 'Falla en la impresora'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes de Trabajo'),
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
                  label: Text('Cliente',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const DataColumn(
                  label: Text('Hora de Inicio',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const DataColumn(
                  label: Text('Duración (min)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const DataColumn(
                  label: Text('Descripción del Problema',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const DataColumn(
                  label: Text('Puntuación',
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
                          Text(report['Cliente']),
                          showEditIcon: false,
                        ),
                        DataCell(
                          Text(report['Hora de Inicio']),
                          showEditIcon: false,
                        ),
                        DataCell(
                          Text(report['Duración']),
                          showEditIcon: false,
                        ),
                        DataCell(
                          Text(report['Descripción del Problema']),
                          showEditIcon: false,
                        ),
                        DataCell(
                          Row(
                            children: List.generate(
                              5,
                              (index) => IconButton(
                                icon: Icon(
                                  Icons.star,
                                  color: index < report['Puntuación']
                                      ? Colors.orange
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _reports[_reports.indexOf(report)]
                                        ['Puntuación'] = index + 1;
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
