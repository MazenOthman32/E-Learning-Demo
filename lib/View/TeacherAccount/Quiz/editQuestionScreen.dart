import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Growing_Minds/Resources/color_resources.dart';

class EditQuestionScreen extends StatefulWidget {
  final Map<String, dynamic> question;
  final String questionId; // Firestore document ID

  EditQuestionScreen({required this.question, required this.questionId});

  @override
  _EditQuestionScreenState createState() => _EditQuestionScreenState();
}

class _EditQuestionScreenState extends State<EditQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController questionController;
  late TextEditingController option1Controller;
  late TextEditingController option2Controller;
  late TextEditingController option3Controller;
  late TextEditingController option4Controller;
  late TextEditingController answerController;

  @override
  void initState() {
    super.initState();
    questionController = TextEditingController(
      text: widget.question['question'],
    );
    option1Controller = TextEditingController(text: widget.question['option1']);
    option2Controller = TextEditingController(text: widget.question['option2']);
    option3Controller = TextEditingController(text: widget.question['option3']);
    option4Controller = TextEditingController(text: widget.question['option4']);
    answerController = TextEditingController(text: widget.question['answer']);
  }

  Future<void> _updateQuestion() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('questions')
            .doc(widget.questionId)
            .update({
              'question': questionController.text.trim(),
              'option1': option1Controller.text.trim(),
              'option2': option2Controller.text.trim(),
              'option3': option3Controller.text.trim(),
              'option4': option4Controller.text.trim(),
              'answer': answerController.text.trim(),
            });

        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update question: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primary,
      appBar: AppBar(
        title: Text("Edit Question"),
        backgroundColor: ColorResources.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: questionController,
                decoration: InputDecoration(labelText: 'Question'),
              ),
              TextFormField(
                controller: option1Controller,
                decoration: InputDecoration(labelText: 'Option 1'),
              ),
              TextFormField(
                controller: option2Controller,
                decoration: InputDecoration(labelText: 'Option 2'),
              ),
              TextFormField(
                controller: option3Controller,
                decoration: InputDecoration(labelText: 'Option 3'),
              ),
              TextFormField(
                controller: option4Controller,
                decoration: InputDecoration(labelText: 'Option 4'),
              ),
              TextFormField(
                controller: answerController,
                decoration: InputDecoration(labelText: 'Correct Answer'),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _updateQuestion,
                  style: ElevatedButton.styleFrom(
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
                      Icon(Icons.update, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Update Question",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:Growing_Minds/Resources/color_resources.dart';
//
// class EditQuestionScreen extends StatefulWidget {
//   final Map<String, dynamic> question;
//   final String questionId; // Firestore document ID
//
//   EditQuestionScreen({required this.question, required this.questionId});
//
//   @override
//   _EditQuestionScreenState createState() => _EditQuestionScreenState();
// }
//
// class _EditQuestionScreenState extends State<EditQuestionScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController questionController;
//   late TextEditingController option1Controller;
//   late TextEditingController option2Controller;
//   late TextEditingController option3Controller;
//   late TextEditingController option4Controller;
//   late TextEditingController answerController;
//
//   @override
//   void initState() {
//     super.initState();
//     questionController = TextEditingController(
//       text: widget.question['question'],
//     );
//     option1Controller = TextEditingController(text: widget.question['option1']);
//     option2Controller = TextEditingController(text: widget.question['option2']);
//     option3Controller = TextEditingController(text: widget.question['option3']);
//     option4Controller = TextEditingController(text: widget.question['option4']);
//     answerController = TextEditingController(text: widget.question['answer']);
//   }
//
//   Future<void> _updateQuestion() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         await FirebaseFirestore.instance
//             .collection('questions')
//             .doc(widget.questionId)
//             .update({
//               'question': questionController.text.trim(),
//               'option1': option1Controller.text.trim(),
//               'option2': option2Controller.text.trim(),
//               'option3': option3Controller.text.trim(),
//               'option4': option4Controller.text.trim(),
//               'answer': answerController.text.trim(),
//             });
//
//         Navigator.pop(context, true);
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to update question: $e')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorResources.primary,
//       appBar: AppBar(
//         title: Text("Edit Question"),
//         backgroundColor: ColorResources.primary,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: questionController,
//                 decoration: InputDecoration(labelText: 'Question'),
//               ),
//               TextFormField(
//                 controller: option1Controller,
//                 decoration: InputDecoration(labelText: 'Option 1'),
//               ),
//               TextFormField(
//                 controller: option2Controller,
//                 decoration: InputDecoration(labelText: 'Option 2'),
//               ),
//               TextFormField(
//                 controller: option3Controller,
//                 decoration: InputDecoration(labelText: 'Option 3'),
//               ),
//               TextFormField(
//                 controller: option4Controller,
//                 decoration: InputDecoration(labelText: 'Option 4'),
//               ),
//               TextFormField(
//                 controller: answerController,
//                 decoration: InputDecoration(labelText: 'Correct Answer'),
//               ),
//               SizedBox(height: 20),
//               Container(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _updateQuestion,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: ColorResources.secondry,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//                     elevation: 5,
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.update, color: Colors.white),
//                       SizedBox(width: 8),
//                       Text(
//                         "Update Question",
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:Growing_Minds/Resources/color_resources.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../Resources/dataBaseHelper.dart';
//
// class EditQuestionScreen extends StatefulWidget {
//   final Map<String, dynamic> question;
//
//   EditQuestionScreen({required this.question});
//
//   @override
//   _EditQuestionScreenState createState() => _EditQuestionScreenState();
// }
//
// class _EditQuestionScreenState extends State<EditQuestionScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController questionController;
//   late TextEditingController option1Controller;
//   late TextEditingController option2Controller;
//   late TextEditingController option3Controller;
//   late TextEditingController option4Controller;
//   late TextEditingController answerController;
//
//   @override
//   void initState() {
//     super.initState();
//     questionController = TextEditingController(text: widget.question['question']);
//     option1Controller = TextEditingController(text: widget.question['option1']);
//     option2Controller = TextEditingController(text: widget.question['option2']);
//     option3Controller = TextEditingController(text: widget.question['option3']);
//     option4Controller = TextEditingController(text: widget.question['option4']);
//     answerController = TextEditingController(text: widget.question['answer']);
//   }
//
//   void _updateQuestion() async {
//     if (_formKey.currentState!.validate()) {
//       await DatabaseHelper.instance.updateQuestion(widget.question['id'], {
//         'question': questionController.text,
//         'option1': option1Controller.text,
//         'option2': option2Controller.text,
//         'option3': option3Controller.text,
//         'option4': option4Controller.text,
//         'answer': answerController.text,
//       });
//
//       Navigator.pop(context, true);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorResources.primary,
//       appBar: AppBar(title: Text("Edit Question"),backgroundColor: ColorResources.primary,),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(controller: questionController, decoration: InputDecoration(labelText: 'Question')),
//               TextFormField(controller: option1Controller, decoration: InputDecoration(labelText: 'Option 1')),
//               TextFormField(controller: option2Controller, decoration: InputDecoration(labelText: 'Option 2')),
//               TextFormField(controller: option3Controller, decoration: InputDecoration(labelText: 'Option 3')),
//               TextFormField(controller: option4Controller, decoration: InputDecoration(labelText: 'Option 4')),
//               TextFormField(controller: answerController, decoration: InputDecoration(labelText: 'Correct Answer')),
//               SizedBox(height: 20),
//               Container(
//                 width: double.infinity,
//                 child: ElevatedButton(onPressed: _updateQuestion,  style: ElevatedButton.styleFrom(
//                   backgroundColor: ColorResources.secondry,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//                   elevation: 5,
//                 ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.update, color: Colors.white),
//                       SizedBox(width: 8),
//                       Text(
//                         "Update Question",
//
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
