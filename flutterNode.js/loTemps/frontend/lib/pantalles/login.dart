import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'consultar.dart';
import 'dart:convert';
import 'registre.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final url = Uri.parse('http://10.0.2.2:3000/usuaris/login');

  final TextEditingController _nomUsuariController = TextEditingController();
  final TextEditingController _contrassenyaController = TextEditingController();

  bool carregant = false;

  Future<void> login() async {

    if (_nomUsuariController.text.isEmpty || _contrassenyaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Omple tots els camps')));
      return;
    }

    setState(() {
      carregant = true;
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nomUsuari': _nomUsuariController.text,
          'contrassenya': _contrassenyaController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data['token'];

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Benvingut!'), duration: Duration(seconds: 3)),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Consultar()),
        );
      } else {
        final error = jsonDecode(response.body)['error'];
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(error),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('D\'acord'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Gestionem errors de connexió
      setState(() {
        carregant = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en la connexió')),
      );
    }

    // Finalment, aturem el loader independentment de si hi ha èxit o error
    setState(() {
      carregant = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nomUsuariController,
                decoration: InputDecoration(
                  labelText: 'Usuari',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              SizedBox(height: 18),
              TextField(
                controller: _contrassenyaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contrassenya',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: carregant ? null : login, // Disable si està carregant
                child: carregant
                    ? CircularProgressIndicator(color: Colors.white) // Mostrem un indicador de càrrega
                    : Text('Iniciar Sessió', style: TextStyle(fontSize: 21)),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Registre(),
                    ),
                  );
                },
                child: Text('Registra\'t', style: TextStyle(fontSize: 17)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
