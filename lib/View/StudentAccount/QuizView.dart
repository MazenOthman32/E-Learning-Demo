import 'dart:async';
import 'package:Growing_Minds/Resources/color_resources.dart';

import 'package:flutter/material.dart';
import '../../Resources/dataBaseHelper.dart';
import '../TeacherAccount/Quiz/resultsView.dart';

class QuizView extends StatefulWidget {
  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  List<Map<String, dynamic>> questions = [];
  int currentIndex = 0;
  int score = 0;
  int timer = 30;
  late Timer _timer;
  String? selectedAnswer;
  bool answered = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() async {
    questions = await DatabaseHelper.instance.getQuestions();
    if (questions.isNotEmpty) _startTimer();
    setState(() {});
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.timer == 0) {
        _nextQuestion();
      } else {
        setState(() => this.timer--);
      }
    });
  }

  void _nextQuestion() {
    _timer.cancel();
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        timer = 30;
        selectedAnswer = null;
        answered = false;
      });
      _startTimer();
    } else {
      _showResults();
    }
  }

  void _checkAnswer(String answer) {
    if (!answered) {
      setState(() {
        selectedAnswer = answer;
        answered = true;
        if (answer == questions[currentIndex]['answer']) {
          score++;
        }
      });
    }
  }

  void _showResults() {
    _timer.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsView(score: score, total: questions.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) return Center(child: CircularProgressIndicator());

    var question = questions[currentIndex];
    return Scaffold(

      backgroundColor: ColorResources.primary,
      appBar: AppBar(

        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => _showWarningSheet(context),
        ),
        backgroundColor: ColorResources.primary,
        elevation: 0,
        title: Text("Social Study Test", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(Icons.timer, color: Colors.black),
                SizedBox(width: 5),
                Text("$timer", style: TextStyle(color: Colors.black, fontSize: 18)),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (currentIndex + 1) / questions.length,
              backgroundColor: Colors.grey[300],
              color: Colors.purple,
            ),
            SizedBox(height: 20),
            Text(
              "Question ${currentIndex + 1} of ${questions.length}",
              style: TextStyle(fontSize: 16, color: Colors.purple),
            ),
            SizedBox(height: 10),
            Text(
              question['question'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...['option1', 'option2', 'option3', 'option4'].map((optionKey) {
              Color borderColor = Colors.grey.shade300;
              if (answered) {
                if (question[optionKey] == question['answer']) {
                  borderColor = Colors.green;
                } else if (selectedAnswer == question[optionKey]) {
                  borderColor = Colors.red;
                }
              }
              return GestureDetector(
                onTap: () => _checkAnswer(question[optionKey]),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        question[optionKey],
                        style: TextStyle(fontSize: 18),
                      ),
                      if (answered && question[optionKey] == question['answer'])
                        Icon(Icons.check_circle, color: Colors.green),
                      if (answered && selectedAnswer == question[optionKey] && selectedAnswer != question['answer'])
                        Icon(Icons.cancel, color: Colors.red),
                    ],
                  ),
                ),
              );
            }).toList(),
SizedBox(height: 40,),
            ElevatedButton(
              onPressed: _nextQuestion,
              child: Text("Next", style: TextStyle(fontSize: 18,color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorResources.secondry,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
void _showWarningSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        color: ColorResources.primary,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Warning!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(height: 10),
            Text(
              "You will lose your progress if you leave now.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16 , color: Colors.black54),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: Text("Cancel" , style: TextStyle(color: Colors.white),),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/studentMainView');
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text("Leave" , style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
