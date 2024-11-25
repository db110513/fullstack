import 'package:flutter/material.dart';
import 'confirmar.dart'; // Importa Confirmar per la navegació

class Menjar extends StatefulWidget {
  final String token;

  Menjar({required this.token});

  @override
  _MenjarState createState() => _MenjarState();
}

class _MenjarState extends State<Menjar> {
  final List<Map<String, dynamic>> plats = [
    {'nom': 'Pizza Margarita', 'preu': 12.99, 'imatge': 'https://example.com/pizza_margarita.jpg'},
    {'nom': 'Hamburguesa', 'preu': 9.99, 'imatge': 'https://example.com/hamburguesa.jpg'},
    {'nom': 'Sushi', 'preu': 15.99, 'imatge': 'https://example.com/sushi.jpg'},
    {'nom': 'Amanida', 'preu': 7.99, 'imatge': 'https://example.com/amanida.jpg'},
  ];

  List<Map<String, dynamic>> carro = [];
  double total = 0;

  void _afegirAlCarro(Map<String, dynamic> plat) {
    setState(() {
      carro.add(plat);
      total += plat['preu'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: plats.length,
        itemBuilder: (context, index) {
          final plat = plats[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Image.network(plat['imatge'], width: 50, height: 50, fit: BoxFit.cover),
              title: Text(plat['nom']),
              subtitle: Text('${plat['preu']} €'),
              trailing: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  _afegirAlCarro(plat);
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: carro.isEmpty
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Confirmar(carro: carro, total: total),
                    ),
                  );
                },
          child: Text('Compra'),
        ),
      ),
    );
  }
}
