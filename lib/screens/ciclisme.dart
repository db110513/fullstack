import 'package:flutter/material.dart';
import '../styles/app_styles.dart';

class Ciclisme extends StatefulWidget {
  const Ciclisme({Key? key}) : super(key: key);

  State<Ciclisme> createState() => _CiclismeState();
}

class _CiclismeState extends State<Ciclisme> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ciclisme', style: TextStyle(fontSize: 30)),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            AppStyles.sizedBoxHeight20,

          ],
        ),
      ),
    );
  }
}