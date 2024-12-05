import 'package:flutter/material.dart';

class Linies extends StatefulWidget {
  const Linies({Key? key}) : super(key: key);

  State<Linies> createState() => _LiniesState();
}

class _LiniesState extends State<Linies> {

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text('Linies', style: TextStyle(fontSize: 40)),
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