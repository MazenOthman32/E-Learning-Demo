import 'package:Growing_Minds/Resources/color_resources.dart';
import 'package:Growing_Minds/View/StudentAccount/cartView.dart';
import 'package:Growing_Minds/View/StudentAccount/studentProfileView.dart';
import 'package:flutter/material.dart';
import '../../Components/bottomNavBar.dart';
import '../TeacherAccount/Dashboard/teacherDashbordView.dart';
import '../test2.dart';
import 'Home/homeView.dart';

class StudentMainView extends StatefulWidget {
  @override
  _StudentMainViewState createState() => _StudentMainViewState();
}

class _StudentMainViewState extends State<StudentMainView> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeView(),
    CartView(),
    StudentProfileView(),

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
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
