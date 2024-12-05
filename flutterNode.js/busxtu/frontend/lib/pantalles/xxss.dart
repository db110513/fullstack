import 'package:flutter/material.dart';

class XXSS extends StatefulWidget {
  const XXSS({Key? key}) : super(key: key);

  State<XXSS> createState() => _XXSSState();
}

class _XXSSState extends State<XXSS> {

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text('XXSS', style: TextStyle(fontSize: 40)),
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