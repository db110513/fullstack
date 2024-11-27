import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Formulari extends StatefulWidget {

  _FormulariState createState() => _FormulariState();
}

class _FormulariState extends State<Formulari> {

  final _nomController = TextEditingController();
  final _direccioController = TextEditingController();

  Future<void> enviarComanda() async {

    final url = Uri.parse('http://10.0.2.2:5000/comandes/crea');

    final String nomClient = _nomController.text;
    final String direccio = _direccioController.text;

    if (nomClient.isNotEmpty && direccio.isNotEmpty) {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'nomClient': nomClient,
          'direccio': direccio,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Comanda enviada!')));
        // Redirigir a una altra pàgina si és necessari
        // Navigator.pushNamed(context, '/home');
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al enviar la comanda')));
      }
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Introdueix tots els camps')));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dades d\'enviament'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomController,
              decoration: InputDecoration(
                labelText: 'Nom del client',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _direccioController,
              decoration: InputDecoration(
                labelText: 'Direcció',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: enviarComanda,
              child: Text('Envia la comanda'),
            ),
          ],
        ),
      ),
    );
  }
}
