import 'package:flutter/material.dart';
import '../styles/app_styles.dart';

class Hockey extends StatefulWidget {
  const Hockey({Key? key}) : super(key: key);

  State<Hockey> createState() => _HockeyState();
}

class _HockeyState extends State<Hockey> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Hoquei', style: TextStyle(fontSize: 30)),
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