import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Registre extends StatefulWidget {
  _RegistreState createState() => _RegistreState();
}

class _RegistreState extends State<Registre> {

  final TextEditingController _usuariController = TextEditingController();
  final TextEditingController _contrassenyaController = TextEditingController();

  void registre() async {

    final usuari = _usuariController.text;
    final contrassenya = _contrassenyaController.text;

    if (usuari.isNotEmpty && contrassenya.isNotEmpty) {

      final response = await http.post(
        Uri.parse('http://localhost:3000/api/usuaris/registre'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'usuari': usuari,
          'contrasenya': contrassenya,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registre exitós')),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error en el registre')),
        );
      }
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Omple tots els camps')),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _usuariController,
                decoration: InputDecoration(
                  labelText: 'Usuari',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _contrassenyaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contrassenya',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: registre,
                child: Text('Registra\'t'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
