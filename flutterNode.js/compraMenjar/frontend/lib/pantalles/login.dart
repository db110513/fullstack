import 'package:flutter/material.dart';

class Login extends StatefulWidget {

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _usuariController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  void login() async {

    final usuari = _usuariController.text;
    final password = _passwordController.text;

    if (usuari.isNotEmpty && password.isNotEmpty) {
      print('Intentant login amb: $usuari i $password');

    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Si us plau, omple tots els camps')),
      );
    }
  }


  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usuariController,
              decoration: InputDecoration(labelText: 'Correu electrònic'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contrasenya'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text('Iniciar Sessió'),
            ),
          ],
        ),
      ),
    );
  }
}
