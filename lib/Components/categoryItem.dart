import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String iconPath;

  const CategoryItem({required this.title, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
            ),
            child: Image.asset(iconPath, width: 50, height: 50),
          ),
          SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
