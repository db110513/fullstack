import 'package:flutter/material.dart';
import '../serveis/serveis_usuari.dart';
import 'consultar.dart';
import 'registre.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _nomUsuariController = TextEditingController();
  final TextEditingController _contrassenyaController = TextEditingController();

  final ServeisUsuari _serveisUsuari = ServeisUsuari();
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
      final data = await _serveisUsuari.login(
        _nomUsuariController.text,
        _contrassenyaController.text,
      );

      String token = data['token'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Benvingut!')));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Consultar()),
      );
    }
    catch (e) {
      setState(() {
        carregant = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error en la connexió')));
    }
    finally {
      setState(() {
        carregant = false;
      });
    }
  }

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
                onPressed: carregant ? null : login,
                child: carregant
                    ? CircularProgressIndicator(color: Colors.white)
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
