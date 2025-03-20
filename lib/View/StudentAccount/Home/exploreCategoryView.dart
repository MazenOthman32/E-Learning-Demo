import 'package:flutter/material.dart';

import '../../../Components/categoryItem.dart';

class ExploreCategoryView extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'title': 'Math', 'icon': 'assets/math.png'},
    {'title': 'Science', 'icon': 'assets/science.png'},
    {'title': 'Grammar', 'icon': 'assets/grammar.png'},
    {'title': 'Music', 'icon': 'assets/music.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Educational Game Hub", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((category) => CategoryItem(title: category['title']!, iconPath: category['icon']!)).toList(),
          ),
        ),
      ],
    );
  }
}