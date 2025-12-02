import 'package:flutter/material.dart';
import '../styles/app_styles.dart';

class ActCardio extends StatefulWidget {
  const ActCardio({Key? key}) : super(key: key);

  State<ActCardio> createState() => _ActCardioState();
}

class _ActCardioState extends State<ActCardio> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ActCardio', style: AppStyles.appBarText),
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