import 'package:Growing_Minds/Resources/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/categoryChip.dart';
import '../../Components/subjectCard.dart';
import '../../Resources/image_Resources.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  String selectedCategory = "All";
  final List<Map<String, dynamic>> courses = [
    {
      "title": "Social Study",
      "price": "\$600",
      "duration": "12 Lessons - 28 hrs 40 mins",
      "color": Colors.red.shade400,
      "category": "Social Study",
      "image": ImageResources.scienceCardPng
    },
    {
      "title": "Maths & Puzzle",
      "price": "\$400",
      "duration": "12 Lessons - 28 hrs 40 mins",
      "color": Colors.green.shade400,
      "category": "Math",
      "image": ImageResources.mathCardPng
    },

    {
      "title": "English",
      "price": "\$250",
      "duration": "12 Lessons - 35 hrs 40 mins",
      "color": Colors.teal.shade400,
      "category": "English",
      "image": ImageResources.englishCardPng
    },
    {
      "title": "Art & Drawing",
      "price": "\$150",
      "duration": "12 Lessons - 28 hrs 40 mins",
      "color": Colors.blue.shade400,
      "category": "Design",
      "image": ImageResources.artCardPng
    },
    {
      "title": "Science Experiments",
      "price": "\$200",
      "duration": "15 Lessons - 30 hrs",
      "color": Colors.purple.shade400,
      "category": "Science",
      "image": ImageResources.scienceCardPng
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHomeSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: ColorResources.secondry,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Good Evening", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
            SizedBox(height: 4),
            Text("Discover New Courses Here !", style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Here...",
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("LearnEase", style: GoogleFonts.poppins(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold)),
        Text("Explore, Learn, Succeed", style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54)),
        SizedBox(height: 10),
        _buildCategories(),
        SizedBox(height: 20),
        Column(
          children: courses.where((course) => selectedCategory == "All" || course["category"] == selectedCategory)
              .map((course) => SubjectCard(course))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoryChip(title: "All", selectedCategory: selectedCategory, onSelected: _updateCategory),
          CategoryChip(title: "English", selectedCategory: selectedCategory, onSelected: _updateCategory),
          CategoryChip(title: "Social Study", selectedCategory: selectedCategory, onSelected: _updateCategory),
          CategoryChip(title: "Math", selectedCategory: selectedCategory, onSelected: _updateCategory),
          CategoryChip(title: "Science", selectedCategory: selectedCategory, onSelected: _updateCategory),
          CategoryChip(title: "Design", selectedCategory: selectedCategory, onSelected: _updateCategory),
        ],
      ),
    );
  }

  void _updateCategory(String title) {
    setState(() {
      selectedCategory = title;
    });
  }


}
