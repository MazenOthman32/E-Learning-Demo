import 'package:Growing_Minds/View/Auth/SignUpView.dart';
import 'package:Growing_Minds/View/Auth/forgetPassView.dart';
import 'package:Growing_Minds/View/StudentAccount/QuizView.dart';
import 'package:Growing_Minds/View/StudentAccount/studentMainView.dart';
import 'package:Growing_Minds/View/TeacherAccount/Dashboard/teacherDashbordView.dart';
import 'package:Growing_Minds/View/TeacherAccount/Dashboard/teacherProfileView.dart';
import 'package:Growing_Minds/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'View/Auth/loginView.dart';
import 'View/Auth/onBoardingView.dart';
import 'View/TeacherAccount/Quiz/resultsView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          FirebaseAuth.instance.currentUser == null
              ? OnBoardingView()
              : StudentMainView(),
      initialRoute: '/',
      routes: {
        '/studentMainView': (context) => StudentMainView(),
        '/teacherMainView': (context) => TeacherDashboardView(),
        '/results': (context) => ResultsView(score: 0, total: 0),
        '/quiz': (context) => QuizView(),
        '/login': (context) => LoginView(),
        '/teacherDashboardView': (context) => TeacherDashboardView(),
        '/teacherProfileView': (context) => TeacherProfileView(),
        '/signUp': (context) => SignUpView(),
        '/forgetPassword': (context) => ForgetPasswordView(),
      },
    );
  }
}
