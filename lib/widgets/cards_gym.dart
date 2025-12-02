import 'package:flutter/material.dart';
import '../screens/zona_cardio.dart';
import '../screens/zona_fitness.dart';
import '../screens/easy_line.dart';
import '../screens/my_wellness.dart';
import '../styles/app_colors.dart';

class CardsGym extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback onTap;

  const CardsGym({required this.text, required this.color, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 185,
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CardsGymGrid extends StatelessWidget {
  const CardsGymGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 22,
      children: [
        CardsGym(text: 'ZONA FITNESS', color: AppColors.redPalette[900],
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ZonaFitness()))
        ),
        CardsGym(text: 'ZONA CARDIO', color: AppColors.redPalette[500],
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ZonaCardio()))
        ),
        CardsGym(text: 'EASY LINE', color: AppColors.redPalette[700],
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EasyLine()))
        ),
        CardsGym(text: 'MY WELLNESS', color: AppColors.redPalette[800],
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyWellness()))
        ),
      ],
    );
  }
}
