import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart';

class Registre extends StatefulWidget {
  _RegistreState createState() => _RegistreState();
}

class _RegistreState extends State<Registre> {

  final url = Uri.parse('http://10.0.2.2:3000/usuaris/registre');

  final TextEditingController _nomUsuariController = TextEditingController();
  final TextEditingController _contrassenyaController = TextEditingController();

  Future<void> registre() async {

    if (_nomUsuariController.text.isEmpty || _contrassenyaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Omple tots els camps')));
      return;
    }

    else if (!(_nomUsuariController.text.length >= 3)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('El nom ha de tindre mínim 3 lletres')));
      return;
    }

    else if (!(_contrassenyaController.text.length >= 6)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('La contrassenya ha de tindre mínim 6 lletres')));
      return;
    }

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nomUsuari': _nomUsuariController.text,
        'contrassenya': _contrassenyaController.text,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuari Creat'),
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
    else {
      // imprimeixo per pantalla el missatge de l'API
      final error = jsonDecode(response.body)['error'];
      print(response.body);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(error),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _nomUsuariController.clear();
                  _contrassenyaController.clear();
                },
                child: const Text('D\'acord'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(36),
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
              const SizedBox(height: 18),
              TextField(
                controller: _contrassenyaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contrassenya',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: registre,
                child: const Text('Registrar', style: TextStyle(fontSize: 21)),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: const Text('Tens compte?', style: TextStyle(fontSize: 17)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}