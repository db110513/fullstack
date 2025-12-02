import 'package:flutter/material.dart';
import '../styles/app_styles.dart';
import '../widgets/table_widget.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Horaris', style: AppStyles.appBarText),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            seccioTitol('Horaris Club'),
            creaTaula([
              ['Recepció',''],
              ['Dl – Dv', '6:00h - 22:00h'],
              ['Ds - Dg', '9:00h - 20:00h'],
              ['Piscina interior', ''],
              ['Dl – Dv', '6:00h - 22:00h'],
              ['Ds – Dg', '9:00h - 20:00h'],
              ['Fitness', ''],
              ['Dl - Dv:', '6:00h - 22:00h'],
              ['Ds:', '9:00h - 20:00h'],
              ['Dg:', '9:00h - 15:00h'],
            ]),
            const SizedBox(height: 20),
            seccioTitol('Horaris Tennis'),
            creaTaula([
              ['Tennis i Pàdel (estiu)', ''],
              ['Dl – Dv:', '09:00 – 14:00h | 16:00 – 22.00h'],
              ['Ds - Dg:', '09:00h - 20:30h'],
              ['Tennis i Pàdel (hivern)', ''],
              ['Dl – Dj:', '09:30 – 13:00h | 15:30 – 22.00h'],
              ['Dv:', '09:00h – 22.00h'],
              ['Ds:', '09:00h – 20:00h'],
              ['Dg:', '09:00h – 15:00h'],
            ]),
            const SizedBox(height: 20),
            seccioTitol('Piscines d’estiu'),
            creaTaula([
              ['Piscina d’estiu\nC/Gaudí', 'Dl - Dg | 10:00 – 20:00h'],
              ['Piscina d’estiu Tennis i Pàdel', 'Dl - Dv | 10:00h – '
                  '14:00h; 16:00h – 20:00h'],
              ['Ds - Dg:', '10:00h – 20:00h'],
            ]),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}