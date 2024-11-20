import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'registre.dart';


class Inici extends StatelessWidget {

  final TextEditingController correuController = TextEditingController();
  final TextEditingController contrassenyaController = TextEditingController();


  void iniciarSessio(BuildContext context) async {

    var url = Uri.parse('http://10.0.2.2:5000/api/usuari/inici');

    var resposta = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'correu': correuController.text,
        'contrassenya': contrassenyaController.text,
      }),
    );

    if (resposta.statusCode == 200) {
      // Obté el token de la resposta
      var dades = json.decode(resposta.body);
      var token = dades['token'];
    }
    else {
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
      appBar: AppBar(
        centerTitle: true,
        title: Text('Inici de Sessió', style: TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: correuController,
              decoration: InputDecoration(
                labelText: 'Correu electrònic',
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
