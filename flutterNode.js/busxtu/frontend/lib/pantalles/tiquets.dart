import 'package:flutter/material.dart';

class Tiquets extends StatefulWidget {
  const Tiquets({Key? key}) : super(key: key);

  State<Tiquets> createState() => _TiquetsState();
}

class _TiquetsState extends State<Tiquets> {

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tiquets', style: TextStyle(fontSize: 40)),
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