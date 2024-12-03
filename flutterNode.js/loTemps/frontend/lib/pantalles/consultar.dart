import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Consultar extends StatefulWidget {

  _ConsultarState createState() => _ConsultarState();
}

class _ConsultarState extends State<Consultar> {
  final TextEditingController _nomController = TextEditingController();
  String? _temps;
  String? _temperatura;

  Future<void> obtenirTemps() async {
    if (_nomController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Introdueix un nom de ciutat')),
      );
      return;
    }

    final String nomCiutat = _nomController.text;

    try {

      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/temps'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"nom": nomCiutat}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _temps = data['temps'];
          _temperatura = data['temperatura'];
        });

      }
      else {
        setState(() {
          _temps = null;
          _temperatura = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ciutat no trobada o error al servidor')),
        );
      }
    }
    catch (e) {
      setState(() {
        _temps = null;
        _temperatura = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en la connexió')),
      );
    }
  }

  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(56),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black
              ),
              controller: _nomController,
              decoration: const InputDecoration(
                labelText: 'Nom de la ciutat',
                labelStyle: TextStyle(color: Colors.black, fontSize: 2),
              ),
            ),

            SizedBox(height: 34),
            ElevatedButton(
              onPressed: obtenirTemps,
              child: const Text('Consultar', style: TextStyle(fontSize: 21)),
            ),

            SizedBox(height: 54),
            if (_temps != null && _temperatura != null) ...[
              Text('Temps: $_temps', style: const TextStyle(
                  fontSize: 20, color: Colors.black)
              ),
              Text('Temperatura: $_temperatura', style: const TextStyle(
                  fontSize: 20, color: Colors.black)
              ),
            ],
          ],
        ),
      ),
    );
  }
}
