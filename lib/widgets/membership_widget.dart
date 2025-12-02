import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../styles/app_styles.dart';
import '../utils/loading.dart';

class MembershipWidget extends StatefulWidget {
  const MembershipWidget({Key? key}) : super(key: key);

  @override
  State<MembershipWidget> createState() => _MembershipWidgetState();
}

class _MembershipWidgetState extends State<MembershipWidget> {
  late final List<Map<String, dynamic>> quotes;
  late final List<Map<String, dynamic>> fitness;
  late final List<Map<String, dynamic>> tennis;

  int selectedQuoteIndex = 0;
  int selectedFitnessIndex = 0;
  int selectedTennisIndex = 0;

  double total = 0;

  @override
  void initState() {
    super.initState();
    quotes = [
      {
        'title': 'Familiar',
        'desc': "Per parelles i fills menors de 24\n",
        'image': 'https://reusdeportiu.org/wp-content/uploads/2019/01/quota-familiar-reus-deportiu-300x226.png',
        'prize': 43.95
      },
      {
        'title': 'Numerari',
        'desc': 'Per majors de 18 anys\n',
        'image': 'https://reusdeportiu.org/wp-content/uploads/2019/01/quota-junior-reus-deportiu-300x226.png',
        'prize': 44.95
      },
      {
        'title': 'Junior',
        'desc': 'Per menors de 18 anys\n',
        'image': 'https://reusdeportiu.org/wp-content/uploads/2019/01/reus-deportiu-quota-junior-300x226.png',
        'prize': 39.20
      },
      {
        'title': 'Pensionista',
        'desc': 'Per majors de 65 anys\n',
        'image': 'https://reusdeportiu.org/wp-content/uploads/2019/01/quota-pensionista-reus-deportiu-300x226.png',
        'prize': 34.15
      }
    ];
    fitness = [
      {
        'title': 'Fitness',
        'desc': "",
        'image': 'https://img.freepik.com/free-vector/dark-black-background-design-with-stripes_1017-38064.jpg?semt=ais_hybrid&w=740&q=80',
        'prize': 0
      },
      {
        'title': 'Mati',
        'desc': "Dl - Dv: 6-14h\n",
        'image': 'https://reusdeportiu.org/wp-content/uploads/2019/01/gym-fitness-reus-deportiu-300x226.png',
        'prize': 16.50
      },
      {
        'title': 'Tarda',
        'desc': 'Dl - Dv: 13-23h\n',
        'image': 'https://reusdeportiu.org/wp-content/uploads/2019/01/quota-gym-reus-deportiu-300x226.png',
        'prize': 18.00
      },
      {
        'title': 'Weekend',
        'desc': 'Ds: 9-21h\nDg: 9-15h\n',
        'image': 'https://reusdeportiu.org/wp-content/uploads/2019/01/gym-reus-deportiu-quota-300x226.png',
        'prize': 12.00
      },
      {
        'title': 'Full time',
        'desc': 'Tots els dies\n',
        'image': 'https://reusdeportiu.org/wp-content/uploads/2019/01/quota-gym-reus-deportiu-fitness-300x226.png',
        'prize': 23.50
      }
    ];
    tennis = [
      {
        'title': 'Tenis',
        'desc': "",
        'image': 'https://img.freepik.com/free-vector/dark-black-background-design-with-stripes_1017-38064.jpg?semt=ais_hybrid&w=740&q=80',
        'prize': 0.0
      },
      {
        'title': 'Tennis/Pàdel',
        'desc': "Per parelles i fills menors de 24.\n",
        'image': 'https://reusdeportiu.org/wp-content/uploads/2019/01/reus-deportiu-quota-tennis-300x226.png',
        'prize': 25.00
      },
      {
        'title': 'Numerari',
        'desc': 'Per majors de 18 anys.\n',
        'image': 'https://reusdeportiu.org/wp-content/uploads/2019/01/quota-tenis-reus-deportiu-300x226.png',
        'prize': 18.00
      },
      {
        'title': 'Junior',
        'desc': 'Per menors de 18 anys.\n',
        'image': 'https://reusdeportiu.org/wp-content/uploads/2019/01/quota-tenis-reus-deportiu-300x226.png',
        'prize': 9.00
      },
      {
        'title': 'Adult',
        'desc': 'Per majors de 65 anys.\n',
        'image': 'https://reusdeportiu.org/wp-content/uploads/2019/01/quota-tennis-300x226.png',
        'prize': 44.35
      }
    ];
    _calculateTotal();
  }

  void _calculateTotal() {
    total = 0;
    total += (quotes[selectedQuoteIndex]['prize'] ?? 0.0).toDouble();
    total += (fitness[selectedFitnessIndex]['prize'] ?? 0.0).toDouble();
    total += (tennis[selectedTennisIndex]['prize'] ?? 0.0).toDouble();
    setState(() {});
  }

  Widget buildCarousel(List<Map<String, dynamic>> items, String title, int selectedIndex, Function(int) onPageChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        CarouselSlider.builder(
          itemCount: items.length,
          itemBuilder: (context, index, realIdx) {
            final item = items[index];
            bool isSelected = index == selectedIndex;
            return Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    item['image']!,
                    fit: BoxFit.cover,
                    loadingBuilder: loading,
                    colorBlendMode: isSelected ? null : BlendMode.darken,
                    color: isSelected ? null : Colors.black.withOpacity(0.5),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black54, Colors.transparent],
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${item['title']}\n',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: item['desc'],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: '${item['prize'].toStringAsFixed(2)}€',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            height: 240,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              onPageChanged(index);
              _calculateTotal();
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Fes-te soci!', style: AppStyles.appBarText),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppStyles.sizedBoxHeight40,
            const Text('Quota fixa + fitness, tennis o pàdel', style: AppStyles.festeSociNormes),
            AppStyles.sizedBoxHeight20,
            Center(
              child: const Text('Seleccionant l\'opció desitjada',
                  style: AppStyles.festeSociNormes),
            ),
            buildCarousel(quotes, "Quotes", selectedQuoteIndex, (i) {
              selectedQuoteIndex = i;
              setState(() {});
            }),
            buildCarousel(fitness, "Fitness", selectedFitnessIndex, (i) {
              selectedFitnessIndex = i;
              setState(() {});
            }),
            buildCarousel(tennis, "Tennis", selectedTennisIndex, (i) {
              selectedTennisIndex = i;
              setState(() {});
            }),
            AppStyles.sizedBoxHeight40,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Preu total: ', style: AppStyles.preuTotal),
                Text('${total.toStringAsFixed(2)}€', style: AppStyles.preuTotalEuros)
              ],
            ),
            AppStyles.sizedBoxHeight40,
          ],
        ),
      ),
    );
  }
}
