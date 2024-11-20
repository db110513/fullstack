import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'registre.dart';

class Inici extends StatelessWidget {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController contrassenyaController = TextEditingController();

  void iniciarSessio(BuildContext context) async {
    var url = Uri.parse('http://10.0.2.2:5000/api/usuari/inici');
    var dades = {
      'nom': nomController.text,
      'contrassenya': contrassenyaController.text,
    };

    print('Enviant dades d\'inici de sessió: $dades'); // Afegit per mostrar les dades a la consola

    var resposta = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(dades),
    );

    print('Resposta d\'inici de sessió: ${resposta.statusCode} - ${resposta.body}'); // Afegit per mostrar la resposta

    if (resposta.statusCode == 200) {
      // Obté el token de la resposta
      var dadesResposta = json.decode(resposta.body);
      var token = dadesResposta['token'];
      print('Token rebut: $token'); // Afegit per mostrar el token
      // Guarda el token o navega a la pantalla principal de l'aplicació
    } else {
      // Mostrar un error
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Error en iniciar sessió'),
          );
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        centerTitle: true,
        title: Text('Benvinguts', style: TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nomController,
              decoration: InputDecoration(
                labelText: 'Nom',
              ),
            ),
            TextField(
              controller: contrassenyaController,
              decoration: InputDecoration(
                labelText: 'Contrassenya',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => iniciarSessio(context),
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
