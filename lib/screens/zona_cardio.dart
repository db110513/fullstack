import 'package:flutter/material.dart';
import '../utils/loading.dart';
import '../styles/app_styles.dart';

class ZonaCardio extends StatefulWidget {
  const ZonaCardio({Key? key}) : super(key: key);

  State<ZonaCardio> createState() => _ZonaCardioState();
}

class _ZonaCardioState extends State<ZonaCardio> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Zona Cardio', style: AppStyles.appBarText),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            AppStyles.sizedBoxHeight20,
            const Text('Compleix els teus objectius de forma eficient i divertida!', style: AppStyles.gymText),
            AppStyles.sizedBoxHeight20,
            Image.network(
              'https://reusdeportiu.org/wp-content/uploads/2024/12/SalaCardio.jpg',
                fit: BoxFit.cover,
                loadingBuilder: loading,
            ),
            AppStyles.sizedBoxHeight20,
            const Text('Màquines de córrer, bicicletes estàtiques de diferents tipus, màquines el·líptiques...', style: AppStyles.gymText),

          ],
        ),
      ),
    );
  }
}