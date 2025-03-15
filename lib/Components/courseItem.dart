import 'package:flutter/material.dart';

class CourseItem extends StatelessWidget {
  final String title;
  final String imagePath;

  const CourseItem({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Image.asset(imagePath, width: 150, height: 100, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}