import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../styles/app_styles.dart';
import '../widgets/temes.dart';
import 'login_widget.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.redAccent),
              title: const Text('Tema', style: AppStyles.drawerText),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Temes()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('Tancar sessió', style: AppStyles.drawerText),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginWidget()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
