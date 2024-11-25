import 'package:flutter/material.dart';
import 'formulari.dart'; // Importa Formulari per la navegació

class Confirmar extends StatelessWidget {
  final List<Map<String, dynamic>> carro;
  final double total;

  Confirmar({required this.carro, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmar Compra'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: carro.length,
              itemBuilder: (context, index) {
                final plat = carro[index];
                return ListTile(
                  title: Text(plat['nom']),
                  subtitle: Text('${plat['preu']} €'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Total: ${total.toStringAsFixed(2)} €'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Formulari(),
                  ),
                );
              },
              child: Text('Confirmar'),
            ),
          ),
        ],
      ),
    );
  }
}
