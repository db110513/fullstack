import 'package:flutter/material.dart';
import 'exports.dart';

class Element {
  final String titol;
  final String imatgeUrl;
  final Function(BuildContext) accio; // Funció per a l'acció associada

  Element(this.titol, this.imatgeUrl, this.accio);
}

class Llista extends StatelessWidget {
  final List<Element> elements = [
    Element("Linies, parades i horaris", "http://10.0.2.2:3000/imatges/llista1.jpg", (context) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Linies()));
    }),
    Element("Estacions preferides", "http://10.0.2.2:3000/imatges/llista2.jpg", (context) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Estacions()));
    }),
    Element("Notícies del servei", "http://10.0.2.2:3000/imatges/llista3.jpg", (context) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Noticies()));
    }),
    Element("Mapa", "http://10.0.2.2:3000/imatges/llista4.jpg", (context) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Mapa()));
    }),
    Element("Targetes i tiquets", "http://10.0.2.2:3000/imatges/llista5.jpg", (context) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Tiquets()));
    }),
    Element("Punts de venta", "http://10.0.2.2:3000/imatges/llista6.jpg", (context) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PuntVenta()));
    }),
    Element("Tiquets virtuals", "http://10.0.2.2:3000/imatges/llista7.jpg", (context) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Tiquetsvirtuals()));
    }),
    Element("Informació", "http://10.0.2.2:3000/imatges/llista8.jpg", (context) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Informacio()));
    }),
    Element("Segueix-nos!", "http://10.0.2.2:3000/imatges/llista9.jpg", (context) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => XXSS()));
    }),
    Element("Web", "http://10.0.2.2:3000/imatges/llista10.jpg", (context) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Web()));
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reus Transport', style: TextStyle(fontSize: 28)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 40, 0),
        child: Column(
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
                        onTap: () => element.accio(context), // Vincula l'acció al clic
                      ),
                      const SizedBox(height: 25),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}