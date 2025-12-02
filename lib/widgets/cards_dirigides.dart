import 'package:flutter/material.dart' hide Step;
import 'package:reus_deportiu/screens/bodypump.dart';
import 'package:reus_deportiu/screens/cycling.dart';
import 'package:reus_deportiu/screens/dance.dart';
import '../screens/act_cardio.dart';
import '../screens/corpore.dart';
import '../screens/gac.dart';
import '../screens/step.dart';
import '../styles/app_colors.dart';

class CardsDirigides extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback onTap;

  const CardsDirigides({required this.text, required this.color, required this.onTap, Key? key}) : super(key: key);

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
          style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CardsDirigidesGrid extends StatelessWidget {
  const CardsDirigidesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        CardsDirigides(text: 'BODYPUMP', color: AppColors.redPalette[900],
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Bodypump()))
        ),
        CardsDirigides(text: 'CYCLING', color: AppColors.redPalette[200],
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Cycling()))
        ),
        CardsDirigides(text: 'DANCE', color: AppColors.redPalette[500],
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Dance()))
        ),
        CardsDirigides(text: 'CORPORE', color: AppColors.redPalette[700],
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Corpore()))
        ),
        CardsDirigides(text: 'GAC', color: AppColors.redPalette[100],
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Gac()))
        ),
        CardsDirigides(text: 'STEP', color: AppColors.redPalette[300],
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Step()))
        ),
      ],
    );
  }
}
