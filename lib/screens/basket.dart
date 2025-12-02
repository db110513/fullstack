import 'package:flutter/material.dart';
import '../styles/app_styles.dart';

class Basket extends StatefulWidget {
  const Basket({Key? key}) : super(key: key);

  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Basquet', style: TextStyle(fontSize: 30)),
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