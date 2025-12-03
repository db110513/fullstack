import 'package:flutter/material.dart';
import '../styles/app_styles.dart';

class Tennis extends StatefulWidget {
  const Tennis({Key? key}) : super(key: key);

  State<Tennis> createState() => _TennisState();
}

class _TennisState extends State<Tennis> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tenis', style: AppStyles.appBarText),
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