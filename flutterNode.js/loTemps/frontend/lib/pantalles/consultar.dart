import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TempsPantalla extends StatefulWidget {
  @override
  _TempsPantallaState createState() => _TempsPantallaState();
}

class _TempsPantallaState extends State<TempsPantalla> {
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
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/temps/$nomCiutat'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _temps = data['temps'];
          _temperatura = data['temperatura'];
        });
      } else {
        setState(() {
          _temps = null;
          _temperatura = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ciutat no trobada o error al servidor')),
        );
      }
    } catch (e) {
      setState(() {
        _temps = null;
        _temperatura = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en la connexió')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta Temps'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomController,
              decoration: InputDecoration(
                labelText: 'Nom de la ciutat',
                labelStyle: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: obtenirTemps,
              child: Text('Consultar', style: TextStyle(fontSize: 21)),
            ),
            SizedBox(height: 24),
            if (_temps != null && _temperatura != null) ...[
              Text('Temps: $_temps', style: TextStyle(fontSize: 18)),
              Text('Temperatura: $_temperatura°C', style: TextStyle(fontSize: 18)),
            ],
            if (_temps == null && _temperatura == null)
              Text('No s\'ha trobat cap dada per aquesta ciutat.', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
