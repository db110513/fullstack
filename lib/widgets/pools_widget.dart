import 'package:flutter/material.dart';
import '../styles/app_styles.dart';
import 'build_carousel.dart';

class PoolsWidget extends StatefulWidget {
  const PoolsWidget({super.key});

  @override
  State<PoolsWidget> createState() => _PoolsWidgetState();
}

class _PoolsWidgetState extends State<PoolsWidget> {
  late final List<Map<String, String>> areas;
  late final List<Map<String, String>> classes;

  @override
  void initState() {
    super.initState();
    areas = [
      {
        'title': "Piscines interiors",
        'desc':
            "Dues piscines climatitzades de 25 i 22 metres per natació i classes dirigides.",
        'image':
            'https://reusdeportiu.org/wp-content/uploads/2019/01/Piscina-Reus-Deportiu.png',
      },
      {
        'title': "Piscines exteriors",
        'desc':
            "Quatre piscines exteriors per gaudir a l’estiu: dues al Gaudí i dues al Tenis-Pàdel.",
        'image':
            'https://reusdeportiu.org/wp-content/uploads/2018/12/Reus-Deportiu-Piscina-exterior.png',
      },
      {
        'title': "Wellness i Spa",
        'desc':
            "Jacuzzi, sauna, banys de vapor i piscina d’hidromassatge per relaxar-te.",
        'image':
            'https://reusdeportiu.org/wp-content/uploads/2019/01/Wellness-Reus-Deportiu.png',
      },
      {
        'title': "Hidroteràpia",
        'desc':
            "La piscina interior petita està especialment recomanada per la gent gran i per a recuperar-se de lesions.",
        'image':
            'https://reusdeportiu.org/wp-content/uploads/2019/01/Piscina-Recuperacio-Reus-Deportiu.png',
      },
    ];
    classes = [
      {
        'title': "Aqua dynamic",
        'desc': "Entrenament aquàtic suau per millorar força i mobilitat.",
        'image':
            'https://reusdeportiu.org/wp-content/uploads/2018/10/aqua-dynamic-reus-deportiu-piscines.jpg',
      },
      {
        'title': "Aquamaster",
        'desc':
            "Ideal per a recuperació de lesions i entrenaments adaptats a tothom.",
        'image':
            'https://reusdeportiu.org/wp-content/uploads/2018/12/Aguagym-Activitats-Dirigides-Reus-Deportiu.png',
      },
      {
        'title': "Aquaprofunda",
        'desc':
            "Classes per a totes les edats durant tot l’any. Aprèn, millora o entrena.",
        'image':
            'https://reusdeportiu.org/wp-content/uploads/2018/10/Aquaprofunda-Reus-Deportiu.png',
      },
      {
        'title': "Aquagac",
        'desc':
            "Ideal per a recuperació de lesions i entrenaments adaptats a tothom.",
        'image':
            'https://reusdeportiu.org/wp-content/uploads/2018/10/Aquatiques-Reus-Deportiu.png',
      },
      {
        'title': "Aquagym",
        'desc':
            "Classes per a totes les edats durant tot l’any. Aprèn, millora o entrena.",
        'image':
            'https://reusdeportiu.org/wp-content/uploads/2018/10/Aquagym-Reus-Deportiu.png',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Piscines', style: AppStyles.appBarText)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppStyles.sizedBoxHeight40,
            const Text('Zones', style: AppStyles.poolHeader),
            AppStyles.sizedBoxHeight20,
            buildCarousel(areas),
            AppStyles.sizedBoxHeight80,
            const Text('Classes Dirigides', style: AppStyles.poolHeader),
            AppStyles.sizedBoxHeight20,
            buildCarousel(classes),
          ],
        ),
      ),
    );
  }
}