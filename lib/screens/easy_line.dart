import 'package:flutter/material.dart';
import '../utils/loading.dart';
import '../styles/app_styles.dart';

class EasyLine extends StatelessWidget {
  const EasyLine({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Easy Line', style: AppStyles.appBarText),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            AppStyles.sizedBoxHeight20,
            const Text('Circuit de màquines hidràuliques pensades per a tots '
                'els tipus de gent, on treballes tan la tracció com la pressió.', style: AppStyles.gymText),
            AppStyles.sizedBoxHeight20,
            Image.network('https://reusdeportiu.org/wp-content/uploads/2024/12/SalaHidraulica.jpg',
                fit: BoxFit.cover,
                loadingBuilder: loading
            ),
            AppStyles.sizedBoxHeight20,
            const Text('Circuit molt complert on treballes tots els grups musculars i que té el benefici que s’adapta a totes les edats i nivells.', style: AppStyles.gymText),
            AppStyles.sizedBoxHeight20,
            const Text('Ideal per treballar la tonificació muscular amb un baix impacte a les articulacions.', style: AppStyles.gymText),
          ],
        ),
      ),
    );
  }
}