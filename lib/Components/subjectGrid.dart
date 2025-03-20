import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectGrid extends StatelessWidget {
  final List<String> subjects;
  final String? selectedSubject;
  final Function(String) onSelect;

  const SubjectGrid({required this.subjects, required this.selectedSubject, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        return BounceInUp(
          child: GestureDetector(
            onTap: () => onSelect(subjects[index]),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: selectedSubject == subjects[index] ? Colors.deepPurpleAccent : Colors.white,
              child: Center(
                child: Text(
                  subjects[index],
                  style: GoogleFonts.poppins(fontSize: 16, color: selectedSubject == subjects[index] ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
