import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class Comandes extends StatefulWidget {

  _ComandesState createState() => _ComandesState();
}

class _ComandesState extends State<Comandes> {

  List<dynamic> comandes = [];
  bool isLoading = true;
  final Random _random = Random();

  void initState() {
    super.initState();
    _obtenirComandes();
  }

  Future<void> _obtenirComandes() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/comandes'));

      if (response.statusCode == 200) {
        setState(() {
          comandes = json.decode(response.body);
          isLoading = false;
        });
      }
      else {
        throw Exception('Error en carregar les comandes');
      }
    }
    catch (error) {
      print(error);
      setState(() {
        isLoading = false;
      });
    }
  }

  String _obtenirEstatAleatori() {
    const List<String> estats = ['cuinant', 'repartint', 'enviat'];
    return estats[_random.nextInt(estats.length)];
  }

  Color _obtenirColorEstat(String estat) {

    switch (estat) {

      case 'cuinant':
        return Colors.red;

      case 'repartint':
        return Colors.yellow;

      case 'enviat':
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comandes'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: comandes.length,
              itemBuilder: (context, index) {
                final comanda = comandes[index];
                String estatAleatori = _obtenirEstatAleatori();

                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      comanda['nomClient'],
                      style: TextStyle(fontSize: 19),
                    ),
                    subtitle: Text(
                      comanda['direccio'],
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Text(
                      estatAleatori,
                      style: TextStyle(
                        fontSize: 22,
                        color: _obtenirColorEstat(estatAleatori),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}