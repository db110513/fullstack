import 'package:flutter/material.dart';

class Noticies extends StatefulWidget {
  const Noticies({Key? key}) : super(key: key);

  State<Noticies> createState() => _NoticiesState();
}

class _NoticiesState extends State<Noticies> {

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text('Noticies', style: TextStyle(fontSize: 40)),
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