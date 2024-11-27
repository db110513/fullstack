import 'package:flutter/material.dart';
import 'formulari.dart';

class Confirmar extends StatelessWidget {

  final List<Map<String, dynamic>> carro;
  final double total;

  Confirmar({required this.carro, required this.total});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmar Compra:'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 35),
          Expanded(
            child: ListView.builder(
              itemCount: carro.length,
              itemBuilder: (context, index) {
                final plat = carro[index];
                return ListTile(
                  title: Text(plat['nom'], style: TextStyle(fontSize: 19)),
                  subtitle: Text('${plat['preu']} €', style: TextStyle(fontSize: 15)),
                );
              },
            ),
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Total: ${total.toStringAsFixed(2)} €', style: TextStyle(fontSize: 19)),
          ),
          const SizedBox(height: 55),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Formulari(),
                  ),
                );
              },
              child: Text('Confirmar', style: TextStyle(fontSize: 19)),
            ),
          ),
          const SizedBox(height: 26),
        ],
      ),
    );
  }
}
