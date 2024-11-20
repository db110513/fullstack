import 'package:flutter/material.dart';

class Registre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar-se'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Nom',
              ),
            ),
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
                // Aquí afegeix la lògica per crear un nou usuari
              },
              child: Text('Registrar-se'),
            ),
          ],
        ),
      ),
    );
  }
}
