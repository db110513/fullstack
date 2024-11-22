import 'package:flutter/material.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Registre extends StatefulWidget {

  _RegistreState createState() => _RegistreState();
}

class _RegistreState extends State<Registre> {

  final TextEditingController _usuariController = TextEditingController();
  final TextEditingController _contrasenyaController = TextEditingController();


  void registre() async {
    final usuari = _usuariController.text;
    final contrassenya = _contrasenyaController.text;

    if (usuari.isNotEmpty && contrassenya.isNotEmpty) {
      print('Dades a enviar al backend: $usuari - $contrassenya');

      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/usuaris/registre'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nomUsuari': usuari,
          'contrassenya': contrassenya,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registre exitós')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error en el registre:')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Si us plau, omple tots els camps')),
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
                  labelText: 'Nom d\'usuari',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _contrasenyaController,
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
                child: Text('Crear Compte'),
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
