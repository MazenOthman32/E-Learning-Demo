import 'package:flutter/material.dart';

import '../../Components/courseItem.dart';

class FeatureCourseView extends StatelessWidget {
  final List<Map<String, String>> courses = [
    {'title': 'Mathematics Basics', 'image': 'assets/course_math.png'},
    {'title': 'Science Wonders', 'image': 'assets/course_science.png'},
    {'title': 'Advanced Grammar', 'image': 'assets/course_grammar.png'},
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Quizzes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: courses.map((course) => CourseItem(title: course['title']!, imagePath: course['image']!)).toList(),
          ),
        ),
      ],
    );
  }
}
