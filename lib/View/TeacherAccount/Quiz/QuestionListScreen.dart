import 'package:Growing_Minds/Resources/color_resources.dart';
import 'package:flutter/material.dart';
import '../../../Resources/dataBaseHelper.dart';
import 'editQuestionScreen.dart';

class QuestionListScreen extends StatefulWidget {
  @override
  _QuestionListScreenState createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  List<Map<String, dynamic>> questions = [];

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() async {
    questions = await DatabaseHelper.instance.getQuestions();
    setState(() {});
  }

  void _deleteQuestion(int id) async {
    await DatabaseHelper.instance.deleteQuestion(id);
    _loadQuestions();
  }

  void _editQuestion(Map<String, dynamic> question) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditQuestionScreen(question: question)),
    );

    if (result == true) _loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primary,
      appBar: AppBar(title: Text("Manage Questions"),backgroundColor: ColorResources.primary,),
      body: questions.isEmpty
          ? Center(child: Text("No Questions Added"))
          : ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          var question = questions[index];
          return Card(
            child: ListTile(
              title: Text(question['question']),
              subtitle: Text("Answer: ${question['answer']}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editQuestion(question),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteQuestion(question['id']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
