import 'package:flutter/material.dart';

class CoordinatorWebView extends StatelessWidget {
  const CoordinatorWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido Coordinador!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: const Text(
                '¿Qué quieres hacer hoy?',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/coordinator/us');
                  },
                  child: const Text('Administrar Usuarios de Soporte'),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/coordinator/clients');
                  },
                  child: const Text('Administrar Clientes'),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/coordinator/reports');
              },
              child: const Text('Calificar Reportes'),
            ),
          ],
        ),
      ),
    );
  }
}
