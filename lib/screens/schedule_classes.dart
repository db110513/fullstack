import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../styles/app_styles.dart';

class ScheduleClasses extends StatefulWidget {
  const ScheduleClasses({Key? key}) : super(key: key);

  State<ScheduleClasses> createState() => _ScheduleClassesState();
}

class _ScheduleClassesState extends State<ScheduleClasses> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Horari Dirigides', style: AppStyles.appBarText),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openUrl();
    });
  }

  Future<void> _openUrl() async {
    final Uri url = Uri.parse('https://reusdeportiu.org/horaris/');
    if (!await launchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

}