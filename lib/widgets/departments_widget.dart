import 'package:flutter/material.dart';
import 'package:reus_deportiu/styles/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../styles/app_styles.dart';

class DepartmentsWidget extends StatelessWidget {
  const DepartmentsWidget({super.key});

  static const List<String> departments = [
    'Bàsquet',
    'Ciclisme',
    'Escacs',
    'Excursionisme',
    'Fotografia',
    'Gimnàstica Rítmica',
    'Hapkido',
    'Hoquei Patins',
    'Karate',
    'Judo',
    'Patinatge Artístic',
    'Pàdel',
    'RD Noves',
    'Tennis',
    'Tennis Taula',
    'Escoles Esportives',
  ];

  static const Map<String, IconData> departmentIcon = {
    'Bàsquet': Icons.sports_basketball,
    'Ciclisme': Icons.directions_bike,
    'Escacs': Icons.videogame_asset_sharp,
    'Excursionisme': Icons.terrain,
    'Fotografia': Icons.camera_alt,
    'Gimnàstica Rítmica': Icons.sports_gymnastics,
    'Hapkido': Icons.sports_martial_arts,
    'Hoquei Patins': Icons.sports_hockey,
    'Karate': Icons.sports_martial_arts,
    'Judo': Icons.sports_martial_arts,
    'Patinatge Artístic': Icons.ice_skating,
    'Pàdel': Icons.sports_tennis,
    'RD Noves': Icons.sports,
    'Tennis': Icons.sports_tennis,
    'Tennis Taula': Icons.sports_tennis,
    'Escoles Esportives': Icons.school,
  };

  static const Map<String, String> departmentUrl = {
    'Bàsquet': 'https://reusdeportiu.org/seccions/basquet/',
    'Ciclisme': 'https://reusdeportiu.org/seccions/ciclisme',
    'Escacs': 'https://reusdeportiu.org/seccions/escacs',
    'Excursionisme': 'https://reusdeportiu.org/seccions/excursionisme',
    'Fotografia': 'https://reusdeportiu.org/seccions/fotografia',
    'Gimnàstica Rítmica': 'https://reusdeportiu.org/seccions/gimnastica-ritmica',
    'Hapkido': 'https://reusdeportiu.org/seccions/hapkido',
    'Hoquei Patins': 'https://reusdeportiu.org/seccions/hoquei',
    'Karate': 'https://reusdeportiu.org/seccions/karate',
    'Judo': 'https://reusdeportiu.org/seccions/judo',
    'Patinatge Artístic': 'https://reusdeportiu.org/seccions/patinatge',
    'Pàdel': 'https://reusdeportiu.org/seccions/padel',
    'RD Noves': 'https://reusdeportiu.org/seccions/rdnoves',
    'Tennis': 'https://reusdeportiu.org/seccions/tennis',
    'Tennis Taula': 'https://reusdeportiu.org/seccions/tennis-taula',
    'Escoles Esportives': 'https://reusdeportiu.org/seccions/escoles-esportives',
  };

  Future<void> _obrirUrl(String url) async {
    final uri = Uri.parse(url);
    if (await launchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
    else debugPrint('No s’ha pogut obrir: $url');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Seccions', style: AppStyles.appBarText),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(6),
        itemCount: departments.length + 1,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, i) {
          if (i == 0) return const SizedBox(height: 0);
          if (i == departments.length) return const SizedBox(height: 40);
          final seccio = departments[i];
          final icona = departmentIcon[seccio];
          final url = departmentUrl[seccio];

          return Align(
            alignment: Alignment.center,
            child: SizedBox(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 50),
                  backgroundColor: AppColors.getRandomColor(),
                  foregroundColor: Colors.black,
                ),
                onPressed: url != null ? () => _obrirUrl(url) : null,
                icon: Icon(icona, size: 30),
                label: Text(seccio, style: AppStyles.menuText),
              ),
            ),
          );
        },
      ),
    );
  }
}