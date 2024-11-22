import 'package:flutter/material.dart';
import 'registre.dart';
import 'dart:convert';


class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usuariController = TextEditingController();
  final TextEditingController _contrasenyaController = TextEditingController();

  void login() async {

    final usuari = _usuariController.text;
    final contrasenya = _contrasenyaController.text;

    if (usuari.isNotEmpty && contrasenya.isNotEmpty) {
      print('Intentant login amb: $usuari i $contrasenya');
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
                  labelText: 'Contrasenya',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: login,
                child: Text('Iniciar Sessió'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registre()),
                  );
                },
                child: Text("Crea't una compta!", style: TextStyle(fontSize: 15)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
