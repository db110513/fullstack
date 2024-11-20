import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Registre extends StatelessWidget {

  var resposta;
  final TextEditingController nomController = TextEditingController();
  final TextEditingController contrassenyaController = TextEditingController();

  void registrar(BuildContext context) async {

    var url = Uri.parse('http://10.0.2.2:5000/api/usuari/registre');

    var dades = {
      'nom': nomController.text,
      'contrassenya': contrassenyaController.text,
    };

    print('Enviant dades de registre: $dades');

    var resposta = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(dades),
    );

    print('Dades a enviar al servidor: ${resposta.body}');

    if (resposta.statusCode == 201) {
      Navigator.pop(context);
    }
    else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Error en registrar l\'usuari'),
          );
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registrar-se', style: TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
              onPressed: () => registrar(context),
              child: Text('Registrar-se'),
            ),
          ],
        ),
      ),
    );
  }
}
