import 'package:flutter/material.dart';
import 'StudentAccount/QuizView.dart';
import 'TeacherAccount/Quiz/QuestionListScreen.dart';
import 'TeacherAccount/Quiz/addQuestionsScreen.dart';

class test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuestionScreen()));
              },
              child: Text("Add Questions"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionListScreen()));
              },
              child: Text("Manage Questions"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => QuizView()));
              },
              child: Text("Take Quiz"),
            ),
          ],
        ),
      ),
    );
  }
}

