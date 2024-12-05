import 'package:flutter/material.dart';

class Mapa extends StatefulWidget {
  const Mapa({Key? key}) : super(key: key);

  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mapa', style: TextStyle(fontSize: 40)),
      ),

      body: Container(
        padding: const EdgeInsets.all(10),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

          ],

        ),

      ),

    );

  }

}