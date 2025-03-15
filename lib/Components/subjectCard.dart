
import 'package:flutter/material.dart';

Widget SubjectCard(Map<String, dynamic> course) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: course["color"],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Image.asset(course["image"], width: 60, height: 60),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(course["title"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(course["price"], style: TextStyle(fontSize: 16, color: Colors.white70)),
            Text(course["duration"], style: TextStyle(fontSize: 14, color: Colors.white60)),
          ],
        ),
      ],
    ),
  );
}
