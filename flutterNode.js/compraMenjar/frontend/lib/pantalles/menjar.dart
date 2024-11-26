import 'package:flutter/material.dart';
import 'confirmar.dart';

class Menjar extends StatefulWidget {
  final String token;

  Menjar({required this.token});

  _MenjarState createState() => _MenjarState();
}

class _MenjarState extends State<Menjar> {

  final List<Map<String, dynamic>> plats = [
    {'nom': 'Pizza Margarita', 'preu': 12.99, 'imatge': 'https://imag.bonviveur.com/pizza-margarita.jpg'},
    {'nom': 'Hamburguesa', 'preu': 9.99, 'imatge': 'https://example.com/hamburguesa.jpg'},
    {'nom': 'Sushi', 'preu': 15.99, 'imatge': 'https://example.com/sushi.jpg'},
    {'nom': 'Amanida', 'preu': 7.99, 'imatge': 'https://example.com/amanida.jpg'},
    {'nom': 'Amanida', 'preu': 7.99, 'imatge': 'https://example.com/amanida.jpg'},
    {'nom': 'Amanida', 'preu': 7.99, 'imatge': 'https://example.com/amanida.jpg'},
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 45),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Tria el menjar:",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: plats.length,
              itemBuilder: (context, index) {
                final plat = plats[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.network(
                        plat['imatge'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.restaurant,
                              size: 40,
                              color: Colors.grey[600],
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    title: Text(plat['nom']),
                    subtitle: Text('${plat['preu'].toStringAsFixed(2)} €'),
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
          ),
        ],
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
          child: Text('Compra (${total.toStringAsFixed(2)} €)'),
        ),
      ),
    );
  }
}