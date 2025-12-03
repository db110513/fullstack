import 'package:flutter/material.dart';
import '../styles/app_styles.dart';

class Ciclisme extends StatelessWidget {
  const Ciclisme({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ciclisme', style: AppStyles.appBarText),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}