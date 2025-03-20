import 'package:Growing_Minds/Resources/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Resources/dataBaseHelper.dart';

class AddQuestionScreen extends StatefulWidget {
  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController option1Controller = TextEditingController();
  final TextEditingController option2Controller = TextEditingController();
  final TextEditingController option3Controller = TextEditingController();
  final TextEditingController option4Controller = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  void _saveQuestion() async {
    if (_formKey.currentState!.validate()) {
      await DatabaseHelper.instance.insertQuestion({
        'question': questionController.text,
        'option1': option1Controller.text,
        'option2': option2Controller.text,
        'option3': option3Controller.text,
        'option4': option4Controller.text,
        'answer': answerController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Question Added')));
      questionController.clear();
      option1Controller.clear();
      option2Controller.clear();
      option3Controller.clear();
      option4Controller.clear();
      answerController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primary,
      appBar: AppBar(title: Text("Add Question",),backgroundColor: ColorResources.primary,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(controller: questionController, decoration: InputDecoration(labelText: 'Question')),
                TextFormField(controller: option1Controller, decoration: InputDecoration(labelText: 'Option 1')),
                TextFormField(controller: option2Controller, decoration: InputDecoration(labelText: 'Option 2')),
                TextFormField(controller: option3Controller, decoration: InputDecoration(labelText: 'Option 3')),
                TextFormField(controller: option4Controller, decoration: InputDecoration(labelText: 'Option 4')),
                TextFormField(controller: answerController, decoration: InputDecoration(labelText: 'Correct Answer')),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: _saveQuestion,  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.secondry,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    elevation: 5,
                  ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.save, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Save Question",
        
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
