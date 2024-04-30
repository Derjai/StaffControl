import 'package:flutter/material.dart';

class CoordinatorClientWebView extends StatelessWidget {
  const CoordinatorClientWebView({super.key});

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
                ],
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('1')),
                      DataCell(Text('Juan')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('2')),
                      DataCell(Text('María')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('3')),
                      DataCell(Text('Pedro')),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Acción para el botón de Crear
                  },
                  child: const Text('Create'),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Acción para el botón de Actualizar
                  },
                  child: const Text('Update'),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Acción para el botón de Borrar
                  },
                  child: const Text('Delete'),
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
