import 'package:flutter/material.dart';

class Web extends StatefulWidget {
  const Web({Key? key}) : super(key: key);

  State<Web> createState() => _WebState();
}

class _WebState extends State<Web> {

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text('Web', style: TextStyle(fontSize: 40)),
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