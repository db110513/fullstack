import 'package:flutter/material.dart';
import '../styles/app_styles.dart';
import '../widgets/cards_gym.dart';

class GymWidget extends StatefulWidget {
  const GymWidget({Key? key}) : super(key: key);

  State<GymWidget> createState() => _GymWidgetState();
}

class _GymWidgetState extends State<GymWidget> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Gimnàs', style: AppStyles.appBarText),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              AppStyles.sizedBoxHeight100,
              const Text('Màquines Technogym!', style: AppStyles.gymQuote),
              AppStyles.sizedBoxHeight20,
              const Text('Monitorització del teu entrenament', style: AppStyles.gymQuote),
              AppStyles.sizedBoxHeight20,
              const Text('Plans d’exercici personalitzats', style: AppStyles.gymQuote),
              AppStyles.sizedBoxHeight60,
              CardsGymGrid()
            ],
          ),
        ),
      ),
    );
  }
}