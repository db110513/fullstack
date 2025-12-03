import 'package:flutter/material.dart';
import 'package:reus_deportiu/screens/classes.dart';
import 'package:reus_deportiu/screens/schedule.dart';
import '../screens/perfil.dart';
import '../styles/app_colors.dart';
import '../styles/app_styles.dart';
import '../screens/departments.dart';
import '../screens/pools.dart';
import '../screens/gym.dart';
import '../screens/membership.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/drawer.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  static final List<Map<String, dynamic>> menuItems = [
    {
      'label': 'Fes-te soci',
      'icon': const Icon(Icons.sports_basketball, size: 30),
      'color': AppColors.redPalette[50],
      'onTap': (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const Membership())),
    },
    {
      'label': 'Classes dirigides',
      'icon': const Icon(Icons.people, size: 30),
      'color': AppColors.redPalette[200],
      'onTap': (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const Classes())),
    },
    {
      'label': 'Horaris',
      'icon': const Icon(Icons.schedule, size: 30),
      'color': AppColors.redPalette[700],
      'onTap': (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const Schedule())),
    },
    {
      'label': 'Seccions',
      'icon': const Icon(Icons.list, size: 30),
      'color': AppColors.redPalette[900],
      'onTap': (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const Departments())),
    },
    {
      'label': 'Gimnàs',
      'icon': const Icon(Icons.fitness_center, size: 30),
      'color': AppColors.redPalette[400],
      'onTap': (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const Gym())),
    },
    {
      'label': 'Piscines',
      'icon': const Icon(Icons.pool, size: 30),
      'color': AppColors.redPalette[500],
      'onTap': (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const Pools())),
    },
    {
      'label': 'Perfil',
      'icon': const Icon(Icons.person, size: 30),
      'color': AppColors.redPalette[700],
      'onTap': (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const Perfil())),
    },
    {
      'label': 'Notícies',
      'icon': const Icon(Icons.newspaper, size: 30),
      'color': AppColors.redPalette[850],
      'onTap': (BuildContext context) async {
        final Uri url = Uri.parse('https://reusdeportiu.org/actualitat/');
        if (!await launchUrl(url)) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No s\'ha pogut obrir la URL')));
        }
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => GestureDetector(
            child: const Icon(Icons.menu),
            onTap: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Menú', style: AppStyles.appBarText),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppStyles.sizedBoxHeight80,
              ...menuItems.expand((item) sync* {
                yield ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: item['color'],
                    fixedSize: const Size(280, 50),
                  ),
                  onPressed: () => item['onTap'](context),
                  icon: item['icon'],
                  label: Text(item['label'], style: AppStyles.menuText),
                );
                yield AppStyles.sizedBoxHeight20;
              }),
            ],
          ),
        ),
      ),
    );
  }
}
