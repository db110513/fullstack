import 'package:flutter/material.dart';
import 'registre.dart';

class Inici extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inici de Sessió'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Correu electrònic',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Contrasenya',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí afegeix la lògica per fer login
              },
              child: Text('Iniciar Sessió'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Registre()),
                );
              },
              child: Text('Crear un compte nou'),
            ),
          ],
        ),
      ),
    );
  }
}
