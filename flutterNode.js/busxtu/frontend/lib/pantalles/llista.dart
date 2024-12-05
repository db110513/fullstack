import 'package:flutter/material.dart';

class Element {
  final String titol;
  final String imatgeUrl;

  Element(this.titol, this.imatgeUrl);
}

class Llista extends StatelessWidget {
  final List<Element> elements = [
    Element("Linies, parades i horaris", "http://10.0.2.2:3000/imatges/llista1.jpg"),
    Element("Estacions preferides", "http://10.0.2.2:3000/imatges/llista2.jpg"),
    Element("Notícies del servei", "http://10.0.2.2:3000/imatges/llista3.jpg"),
    Element("Mapa", "http://10.0.2.2:3000/imatges/llista4.jpg"),
    Element("Targetes i tiquets", "http://10.0.2.2:3000/imatges/llista5.jpg"),
    Element("Punts de venta", "http://10.0.2.2:3000/imatges/llista6.jpg"),
    Element("Tiquets virtuals", "http://10.0.2.2:3000/imatges/llista7.jpg"),
    Element("Informació", "http://10.0.2.2:3000/imatges/llista8.jpg"),
    Element("Segueix-nos!", "http://10.0.2.2:3000/imatges/llista9.jpg"),
    Element("Web", "http://10.0.2.2:3000/imatges/llista10.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reus Transport', style: TextStyle(fontSize: 28)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: elements.length,
              itemBuilder: (context, index) {
                final element = elements[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        child: Image.network(
                          element.imatgeUrl,
                          fit: BoxFit.cover,
                          loadingBuilder:
                              (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                    : null,
                              ),
                            );
                          },
                          errorBuilder:
                              (BuildContext context, Object error, StackTrace? stackTrace) {
                            return Icon(Icons.error);
                          },
                        ),
                      ),
                      title: Text(element.titol, style: TextStyle(fontSize:21)),
                    ),
                    const SizedBox(height: 25),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}