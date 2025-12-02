import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../utils/loading.dart';

Widget buildCarousel(List<Map<String, String>> items) {
  return CarouselSlider(
    items: items.map(
          (item) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
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
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList(),
    options: CarouselOptions(
      height: 240,
      enlargeCenterPage: true,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 5),
      viewportFraction: 0.8,
    ),
  );
}
