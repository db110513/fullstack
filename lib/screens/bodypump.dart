import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../styles/app_styles.dart';

class Bodypump extends StatefulWidget {
  const Bodypump({Key? key}) : super(key: key);

  @override
  State<Bodypump> createState() => _BodypumpState();
}

class _BodypumpState extends State<Bodypump> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bodypump', style: AppStyles.appBarText),
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
    final Uri url = Uri.parse('https://reusdeportiu.org/portfolio-item/bodypump/');
    if (!await launchUrl(url)) {
      debugPrint('No s\'ha pogut obrir la URL');
    }
  }

}