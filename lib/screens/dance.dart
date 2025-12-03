import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../styles/app_styles.dart';

class Dance extends StatefulWidget {
  const Dance({Key? key}) : super(key: key);

  State<Dance> createState() => _DanceState();
}

class _DanceState extends State<Dance> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dance', style: AppStyles.appBarText),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [],
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
    final Uri url = Uri.parse('https://reusdeportiu.org/portfolio-item/dance/');
    if (!await launchUrl(url)) {
      debugPrint('No s\'ha pogut obrir la URL');
    }
  }

}