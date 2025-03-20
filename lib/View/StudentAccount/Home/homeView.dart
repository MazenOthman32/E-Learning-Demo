import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Components/categoryChip.dart';
import '../../../Components/subjectCard.dart';
import '../../../Resources/color_resources.dart';
import '../../../Resources/image_Resources.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  _buildExploreSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorResources.secondry,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Container(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0 ,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Good Evening", style: GoogleFonts.poppins(fontSize: 13, color: Colors.white)),
              SizedBox(height: 4),
              Text("Ahmed Reda", style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildExploreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Educational Game Hub", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text("Fun Learning for Every Subject!", style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54)),
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
      {"title": "Social Studies", "image": ImageResources.scienceCardPng},
      {"title": "Mathematics for Beginners", "image": ImageResources.scienceCardPng},
      {"title": "Physics Experiments", "image": ImageResources.scienceCardPng},
      {"title": "Grammar Mastery", "image": ImageResources.scienceCardPng},
    ];

    return courses.map((course) {
      return GestureDetector(
        onTap: (){
          Navigator.pushReplacementNamed(context, '/quiz');
        },
        child: Card(
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
        ),
      );
    }).toList();
  }

}
