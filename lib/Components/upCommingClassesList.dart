import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingClassesList extends StatelessWidget {
  final List<Map<String, String>> classes;
  const UpcomingClassesList({required this.classes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: classes.map(
            (classItem) => Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Icon(Icons.schedule, color: Colors.deepPurple),
            title: Text(classItem['subject']!, style: GoogleFonts.poppins()),
            subtitle: Text('${classItem['date']} at ${classItem['time']}'),
          ),
        ),
      ).toList(),
    );
  }
}
