import 'package:flutter/material.dart';

class Element {
  final String titol;
  final String imatgeUrl;

  Element(this.titol, this.imatgeUrl);
}

class Llista extends StatelessWidget {

  final List<Element> elements = [
    Element("Linies, parades i horaris", "http://10.0.2.2:3000/imatges/llista1"),
    Element("Estacions preferides", "2222"),
    Element("Notícies del servei", "3333"),
    Element("Mapa", "4444"),
    Element("Targetes i tiquets", "5555"),
    Element("Punts de venta", "6666"),
    Element("Tiquets virtuals", "7777"),
    Element("Informació", "8888"),
    Element("Segueix-nos!", "9999"),
    Element("Web", "10"),
  ];

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Reus Trasnport'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: elements.length,
        itemBuilder: (context, index) {
          final element = elements[index];
          return ListTile(
            leading: Image.network(
              element.imatgeUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return Icon(Icons.error);
              },
            ),
            title: Text(element.titol),
          );
        },
      ),
    );
  }
}