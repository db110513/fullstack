import 'package:flutter/material.dart';
import '../styles/app_styles.dart';
import '../utils/loading.dart';

class ZonaFitness extends StatelessWidget {
  const ZonaFitness({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Zona Fitness', style: AppStyles.appBarText),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            AppStyles.sizedBoxHeight20,
            const Text(
              'Màquines Technogym de la gama més alta i modernes!',
              style: AppStyles.gymText,
            ),
            AppStyles.sizedBoxHeight20,
            SizedBox(
              height: 200,
              child: Image.network(
                'https://reusdeportiu.org/wp-content/uploads/2024/12/SalaGeneral.jpg',
                fit: BoxFit.cover,
                loadingBuilder: loading,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.broken_image, size: 50, color: Colors.red),
                  );
                },
              ),
            ),
            AppStyles.sizedBoxHeight20,
            const Text(
              'Aconsegueix els teus objectius de Fitness de la forma més ràpida, divertida i eficient!',
              style: AppStyles.gymText,
            ),
            AppStyles.sizedBoxHeight20,
            const Text(
              'No dubtis en visitar-nos i posar a prova les nostres maquines!',
              style: AppStyles.gymText,
            ),
          ],
        ),
      ),
    );
  }
}