import 'package:flutter/material.dart';
import 'pantalles/login.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Compra Menjar',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Login(),
    );
  }
}
