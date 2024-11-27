import 'package:flutter/material.dart';
import 'menjar.dart';

class Enviat extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Comanda rebuda !!\n\nEn breu t'arribarà a la \ndirecció "
                    "preporcionada.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 27),
              ),
            ),
            SizedBox(height: 200),
            Text(
              "Ara què?",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Menjar(token: '')), // Passa un token buit o el token actual si el tens
                    );
                  },
                  child: Text('Nova comanda', style: TextStyle(fontSize: 19)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).pop();
                  },
                  child: Text('Tancar sessió', style: TextStyle(fontSize: 19)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}