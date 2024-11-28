import 'package:flutter/material.dart';
import 'formulari.dart';

class Confirmar extends StatefulWidget {
  final List<Map<String, dynamic>> carro;
  final double total;

  Confirmar({required this.carro, required this.total});

  @override
  _ConfirmarState createState() => _ConfirmarState();
}

class _ConfirmarState extends State<Confirmar> {
  late List<Map<String, dynamic>> _carro;
  late double _total;

  @override
  void initState() {
    super.initState();
    _carro = List.from(widget.carro);
    _total = widget.total;
  }

  void _eliminarProducte(int index) {
    setState(() {
      double preuProducte = _carro[index]['preu'];
      _carro.removeAt(index);
      _total -= preuProducte;
    });
  }

  @override
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
              itemCount: _carro.length,
              itemBuilder: (context, index) {
                final plat = _carro[index];
                return Dismissible(
                  key: Key(plat['nom']),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _eliminarProducte(index);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(80, 0, 92, 15),
                    title: Text(plat['nom'], style: TextStyle(fontSize: 19)),
                    subtitle: Text('${plat['preu']} €', style: TextStyle(fontSize: 15)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _eliminarProducte(index),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Total: ${_total.toStringAsFixed(2)} €', style: TextStyle(fontSize: 19)),
          ),
          const SizedBox(height: 55),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: _carro.isNotEmpty
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Formulari(),
                        ),
                      );
                    }
                  : null,
              child: Text('Confirmar', style: TextStyle(fontSize: 19)),
            ),
          ),
          const SizedBox(height: 26),
        ],
      ),
    );
  }
}