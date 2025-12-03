import 'package:flutter/material.dart';
import '../utils/loading.dart';
import '../styles/app_styles.dart';

class MyWellness extends StatelessWidget {
  const MyWellness({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Wellness', style: AppStyles.appBarText),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            AppStyles.sizedBoxHeight20,
            const Text('L\'app “My Wellness” et permetrà, juntament amb les '
                'màquines Technogym, veure els resultats del teu entrenament.', style: AppStyles.gymText),
            AppStyles.sizedBoxHeight20,
            const Text('Pots veure els resultats del teu entrenament', style: AppStyles.gymText),
            AppStyles.sizedBoxHeight20,
            const Text('Els nostres professionals et poden crear un entrenament personal.', style: AppStyles.gymText),
            AppStyles.sizedBoxHeight20,
            Image.network('https://reusdeportiu.org/wp-content/uploads/2019/01/my-wellness-reus-deportiu.jpg',
                fit: BoxFit.cover,
                loadingBuilder: loading,
            )
          ],
        ),
      ),
    );
  }
}