import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Resources/color_resources.dart';

class CategoryChip extends StatelessWidget {
  final String title;
  final String selectedCategory;
  final Function(String) onSelected;

  const CategoryChip({required this.title, required this.selectedCategory, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(title),
        selected: selectedCategory == title,
        onSelected: (bool selected) => onSelected(title),
        backgroundColor: Colors.white,
        selectedColor: ColorResources.secondry,
        labelStyle: GoogleFonts.poppins(fontSize: 15, color: selectedCategory == title ? Colors.white : Colors.black),
      ),
    );
  }
}
