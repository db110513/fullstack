import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../styles/app_styles.dart';

class Step extends StatefulWidget {
  const Step({Key? key}) : super(key: key);

  State<Step> createState() => _StepState();
}

class _StepState extends State<Step> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Step', style: AppStyles.appBarText),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            AppStyles.sizedBoxHeight20,

          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _launchUrl();
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://reusdeportiu.org/portfolio-item/step/');
    if (!await launchUrl(url)) {
      debugPrint('No s\'ha pogut obrir la URL');
    }
  }

}