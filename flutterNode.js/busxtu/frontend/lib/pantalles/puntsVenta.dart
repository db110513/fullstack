import 'package:flutter/material.dart';

class PuntVenta extends StatefulWidget {
  const PuntVenta({Key? key}) : super(key: key);

  State<PuntVenta> createState() => _PuntVentaState();
}

class _PuntVentaState extends State<PuntVenta> {

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text('PuntVenta', style: TextStyle(fontSize: 40)),
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