import 'package:flutter/material.dart';

class Tiquetsvirtuals extends StatefulWidget {
  const Tiquetsvirtuals({Key? key}) : super(key: key);

  State<Tiquetsvirtuals> createState() => _TiquetsvirtualsState();
}

class _TiquetsvirtualsState extends State<Tiquetsvirtuals> {

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tiquetsvirtuals', style: TextStyle(fontSize: 40)),
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