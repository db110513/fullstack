import 'package:flutter/material.dart';
import '../styles/app_styles.dart';

class Chess extends StatefulWidget {
  const Chess({Key? key}) : super(key: key);

  State<Chess> createState() => _ChessState();
}

class _ChessState extends State<Chess> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Escacs', style: TextStyle(fontSize: 30)),
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