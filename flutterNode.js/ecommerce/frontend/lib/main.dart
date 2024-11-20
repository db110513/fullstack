import 'package:flutter/material.dart';
import 'pantalles/inici.dart';

void main() =>  runApp(App());

class App extends StatelessWidget {

  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'E-commerce de Samarretes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Inici(),
    );
  }
}
