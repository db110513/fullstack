import 'package:flutter/material.dart';

class Estacions extends StatefulWidget {
  const Estacions({Key? key}) : super(key: key);

  State<Estacions> createState() => _EstacionsState();
}

class _EstacionsState extends State<Estacions> {

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text('Estacions', style: TextStyle(fontSize: 40)),
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