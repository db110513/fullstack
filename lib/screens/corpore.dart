import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../styles/app_styles.dart';

class Corpore extends StatefulWidget {
  const Corpore({Key? key}) : super(key: key);

  State<Corpore> createState() => _CorporeState();
}

class _CorporeState extends State<Corpore> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Corpore', style: AppStyles.appBarText),
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
    final Uri url = Uri.parse('https://reusdeportiu.org/portfolio-item/corpore/');
    if (!await launchUrl(url)) {
      debugPrint('No s\'ha pogut obrir la URL');
    }
  }

}