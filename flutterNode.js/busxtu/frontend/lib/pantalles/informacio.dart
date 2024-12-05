import 'package:flutter/material.dart';

class Informacio extends StatefulWidget {
  const Informacio({Key? key}) : super(key: key);

  State<Informacio> createState() => _InformacioState();
}

class _InformacioState extends State<Informacio> {

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text('Informacio', style: TextStyle(fontSize: 40)),
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