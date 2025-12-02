import 'package:flutter/material.dart';
import '../styles/app_styles.dart';
import '../widgets/cards_dirigides.dart';
import 'schedule_classes.dart';

class Classes extends StatefulWidget {
  const Classes({Key? key}) : super(key: key);

  State<Classes> createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Classes Dirigides', style: AppStyles.appBarText),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            AppStyles.sizedBoxHeight40,
            Center(
              child: Column(
                children: [
                  const Text('+70 classes setmanals', style: AppStyles.dirigidesText),
                  AppStyles.sizedBoxHeight20,
                  const Text('Tots els horaris possibles!', style: AppStyles.dirigidesText)
                ]
              ),
            ),
            AppStyles.sizedBoxHeight60,
            CardsDirigidesGrid(),
            AppStyles.sizedBoxHeight60,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScheduleClasses())),
                    child: const Text('Horaris', style: AppStyles.dirigidesLink)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}