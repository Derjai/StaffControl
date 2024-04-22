import 'package:flutter/material.dart';

class SupportMobileView extends StatelessWidget {
  const SupportMobileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido Usuario de Soporte!'),
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
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Acción para el tercer botón
              },
              child: const Text('Crear Reporte'),
            ),
          ],
        ),
      ),
    ); // Blank view
  }
}
