import 'package:flutter/material.dart';
import 'confirmar.dart';

class Menjar extends StatefulWidget {
  final String token;

  Menjar({required this.token});

  _MenjarState createState() => _MenjarState();
}

class _MenjarState extends State<Menjar> {

 static const String url = 'http://10.0.2.2:3000/imatges/';

  final List<Map<String, dynamic>> plats = [
    {'nom': 'Pizza Margarita', 'preu': 12.99, 'imatge': '${url}pizza-margarita.jpg'},
    {'nom': 'Hamburguesa', 'preu': 9.99, 'imatge': '${url}hamburguesa.jpg'},
    {'nom': 'Sushi', 'preu': 15.99, 'imatge': '${url}sushi.jpg'},
    {'nom': 'Amanida', 'preu': 7.99, 'imatge': '${url}amanida.jpg'},
    {'nom': 'Pasta', 'preu': 11.99, 'imatge': '${url}pasta.jpg'},
    {'nom': 'Pollastre', 'preu': 13.99, 'imatge': '${url}pollastre.jpeg'},
    {'nom': 'Peix', 'preu': 16.99, 'imatge': '${url}peix.jpg'},
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
        title: Text("Tria el menjar"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      width: 150,
                      height: 150,
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