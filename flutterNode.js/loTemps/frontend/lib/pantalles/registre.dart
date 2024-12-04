import 'package:flutter/material.dart';
import '../serveis/utils.dart';
import 'login.dart';
import '../serveis/serveis_usuari.dart';

class Registre extends StatelessWidget {

  final TextEditingController _nomUsuariController = TextEditingController();
  final TextEditingController _contrassenyaController = TextEditingController();

  final ServeisUsuari _serveisUsuari = ServeisUsuari();


  Widget build(BuildContext context) {

    bool carregant = false;

    Future<void> registre() async {

      if (_nomUsuariController.text.isEmpty || _contrassenyaController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Omple tots els camps')));
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

      carregant = true;

      try {

        final data = await _serveisUsuari.registre(
          _nomUsuariController.text,
          _contrassenyaController.text,
          context
        );

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Usuari Creat')));

        Utils.neteja(_nomUsuariController, _contrassenyaController);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
      catch (e) {
        carregant = false;
        Utils.neteja(_nomUsuariController, _contrassenyaController);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error de connexió')));
      }
      finally {
        carregant = false;
      }
    }

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
              const SizedBox(height: 18),
              TextField(
                controller: _contrassenyaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contrassenya',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              const SizedBox(height: 54),
              if (carregant) CircularProgressIndicator(),
              if (!carregant)
                ElevatedButton(
                  onPressed: registre,
                  child: const Text('Registrar', style: TextStyle(fontSize: 21)),
                ),
              SizedBox(height: 16),
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
