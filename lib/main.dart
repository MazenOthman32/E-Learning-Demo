import 'package:Growing_Minds/View/StudentAccount/Home/homeView.dart';
import 'package:Growing_Minds/View/StudentAccount/QuizView.dart';
import 'package:Growing_Minds/View/StudentAccount/studentMainView.dart';
import 'package:Growing_Minds/View/TeacherAccount/Dashboard/teacherDashbordView.dart';
import 'package:Growing_Minds/View/TeacherAccount/Quiz/addQuestionsScreen.dart';
import 'package:Growing_Minds/View/TeacherAccount/Quiz/editQuestionScreen.dart';
import 'package:flutter/material.dart';

import 'View/Auth/loginView.dart';
import 'View/Auth/onBoardingView.dart';
import 'View/TeacherAccount/Quiz/resultsView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingView(),
      initialRoute: '/',
      routes: {
       //  '/': (context) => (),
        '/studentMainView': (context) => StudentMainView(),
        '/teacherMainView': (context) => TeacherDashboardView(),
        '/results': (context) => ResultsView(score: 0, total: 0),
        '/quiz': (context) => QuizView(),
        '/login': (context) => LoginView(),
        '/teacherDashboardView': (context) => TeacherDashboardView(),
      },
    );
  }
}

