import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/bottomNavBar.dart';
import '../../Components/categoryChip.dart';
import '../../Components/subjectCard.dart';
import '../../Resources/color_resources.dart';
import '../../Resources/image_Resources.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedCategory = "All";
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> courses = [
    {
      "title": "Maths & Puzzle",
      "price": "\$400",
      "duration": "12 Lessons - 28 hrs 40 mins",
      "color": Color(0xffE57373),
      "category": "Math",
      "image": ImageResources.mathCardPng
    },
    {
      "title": "Social Study",
      "price": "\$600",
      "duration": "12 Lessons - 28 hrs 40 mins",
      "color": Colors.redAccent,
      "category": "Social Study",
      "image": ImageResources.scienceCardPng
    },
    {
      "title": "English",
      "price": "\$250",
      "duration": "12 Lessons - 35 hrs 40 mins",
      "color": Colors.teal,
      "category": "English",
      "image": ImageResources.englishCardPng
    },
    {
      "title": "Art & Drawing",
      "price": "\$150",
      "duration": "12 Lessons - 28 hrs 40 mins",
      "color": Colors.blue,
      "category": "Design",
      "image": ImageResources.artCardPng
    },
    {
      "title": "Science Experiments",
      "price": "\$200",
      "duration": "15 Lessons - 30 hrs",
      "color": Colors.deepPurpleAccent,
      "category": "Science",
      "image": ImageResources.scienceCardPng
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                    SizedBox(height: 20),
                    _buildExploreSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
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
            Text("Ahmed Reda", style: GoogleFonts.poppins(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
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

  Widget _buildExploreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Explore Category", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Container(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _buildCategoryItems(),
          ),
        ),
        SizedBox(height: 20),
        Text("Quizzes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Column(children: _buildFeatureCourses()),
      ],
    );
  }

  List<Widget> _buildCategoryItems() {
    List<Map<String, dynamic>> categories = [
      {"title": "Math", "icon": Icons.calculate, "color": Colors.purpleAccent},
      {"title": "Science", "icon": Icons.science, "color": Colors.pinkAccent},
      {"title": "Grammar", "icon": Icons.spellcheck, "color": Colors.redAccent},
      {"title": "Music", "icon": Icons.music_note, "color": Colors.orangeAccent},
    ];

    return categories.map((category) {
      return Container(
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: category['color'],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category['icon'], size: 40, color: Colors.white),
            SizedBox(height: 5),
            Text(category['title'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _buildFeatureCourses() {
    List<Map<String, String>> courses = [
      {"title": "Mathematics for Beginners", "image": ImageResources.scienceCardPng},
      {"title": "Physics Experiments", "image": ImageResources.scienceCardPng},
      {"title": "Grammar Mastery", "image": ImageResources.scienceCardPng},
      {"title": "Learn Music Theory", "image": ImageResources.scienceCardPng},
    ];

    return courses.map((course) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(course['image']!, width: 60, height: 60, fit: BoxFit.cover),
          ),
          title: Text(course['title']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        ),
      );
    }).toList();
  }

}
