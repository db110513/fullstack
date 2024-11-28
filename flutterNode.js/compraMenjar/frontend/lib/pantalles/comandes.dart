import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Comandes extends StatefulWidget {

  _ComandesState createState() => _ComandesState();
}

class _ComandesState extends State<Comandes> {
  List<dynamic> _comandes = [];

  void initState() {
    super.initState();
    _obtenirComandes();
  }

  Future<void> _obtenirComandes() async {
    final url = Uri.parse('http://10.0.2.2:3000/comandes');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {

        setState(() {
          _comandes = json.decode(response.body);
        });
      }
      else {
        throw Exception('Error en carregar les comandes');
      }
    }
    catch (error) {
      print('Error al obtenir les comandes: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al carregar les comandes')));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estat de les Comandes:'),
      ),
      body: ListView.builder(
        itemCount: _comandes.length,
        itemBuilder: (context, index) {
          final comanda = _comandes[index];
          return ListTile(
            contentPadding: EdgeInsets.fromLTRB(20, 22, 0, 0),
            title: Text(comanda['nomClient'], style: TextStyle(fontSize: 18),),
            subtitle: Text(comanda['direccio'], style: TextStyle(fontSize: 20)),
          );
        },
      ),
    );
  }
}