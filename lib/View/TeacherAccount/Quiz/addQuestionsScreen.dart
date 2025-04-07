import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Growing_Minds/Resources/color_resources.dart';

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

  Future<void> _saveQuestionToFirestore() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('questions').add({
          'question': questionController.text.trim(),
          'option1': option1Controller.text.trim(),
          'option2': option2Controller.text.trim(),
          'option3': option3Controller.text.trim(),
          'option4': option4Controller.text.trim(),
          'answer': answerController.text.trim(),
          'timestamp':
              FieldValue.serverTimestamp(), // Optional: to sort questions
        });

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Question Added to Firestore')));

        // Clear all fields
        questionController.clear();
        option1Controller.clear();
        option2Controller.clear();
        option3Controller.clear();
        option4Controller.clear();
        answerController.clear();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primary,
      appBar: AppBar(
        title: Text("Add Question"),
        backgroundColor: ColorResources.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                    onPressed: _saveQuestionToFirestore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorResources.secondry,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:Growing_Minds/Resources/color_resources.dart';
//
// class AddQuestionScreen extends StatefulWidget {
//   @override
//   _AddQuestionScreenState createState() => _AddQuestionScreenState();
// }
//
// class _AddQuestionScreenState extends State<AddQuestionScreen> {
//   String? selectedSubject;
//
//   List<String> subjects = [
//     'Social Studies',
//     'Mathematics for Beginners',
//     'Physics Experiments',
//     'Grammar Mastery',
//   ];
//
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController questionController = TextEditingController();
//   final TextEditingController option1Controller = TextEditingController();
//   final TextEditingController option2Controller = TextEditingController();
//   final TextEditingController option3Controller = TextEditingController();
//   final TextEditingController option4Controller = TextEditingController();
//   final TextEditingController answerController = TextEditingController();
//
//   Future<void> _saveQuestionToFirestore() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         await FirebaseFirestore.instance.collection('questions').add({
//           'subject': selectedSubject, //
//           'question': questionController.text.trim(),
//           'option1': option1Controller.text.trim(),
//           'option2': option2Controller.text.trim(),
//           'option3': option3Controller.text.trim(),
//           'option4': option4Controller.text.trim(),
//           'answer': answerController.text.trim(),
//           'timestamp': FieldValue.serverTimestamp(),
//         });
//
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Question Added to Firestore')));
//
//         // Clear all fields
//         questionController.clear();
//         option1Controller.clear();
//         option2Controller.clear();
//         option3Controller.clear();
//         option4Controller.clear();
//         answerController.clear();
//       } catch (e) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Error: $e')));
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorResources.primary,
//       appBar: AppBar(
//         title: Text("Add Question"),
//         backgroundColor: ColorResources.primary,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 DropdownButtonFormField<String>(
//                   value: selectedSubject,
//                   decoration: InputDecoration(labelText: 'Select Subject'),
//                   items:
//                       subjects.map((subject) {
//                         return DropdownMenuItem(
//                           value: subject,
//                           child: Text(subject),
//                         );
//                       }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedSubject = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null) {
//                       return 'Please select a subject';
//                     }
//                     return null;
//                   },
//                 ),
//
//                 TextFormField(
//                   controller: questionController,
//                   decoration: InputDecoration(labelText: 'Question'),
//                 ),
//                 TextFormField(
//                   controller: option1Controller,
//                   decoration: InputDecoration(labelText: 'Option 1'),
//                 ),
//                 TextFormField(
//                   controller: option2Controller,
//                   decoration: InputDecoration(labelText: 'Option 2'),
//                 ),
//                 TextFormField(
//                   controller: option3Controller,
//                   decoration: InputDecoration(labelText: 'Option 3'),
//                 ),
//                 TextFormField(
//                   controller: option4Controller,
//                   decoration: InputDecoration(labelText: 'Option 4'),
//                 ),
//                 TextFormField(
//                   controller: answerController,
//                   decoration: InputDecoration(labelText: 'Correct Answer'),
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _saveQuestionToFirestore,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: ColorResources.secondry,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(
//                         vertical: 14,
//                         horizontal: 16,
//                       ),
//                       elevation: 5,
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(Icons.save, color: Colors.white),
//                         SizedBox(width: 8),
//                         Text(
//                           "Save Question",
//                           style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
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
// class AddQuestionScreen extends StatefulWidget {
//   @override
//   _AddQuestionScreenState createState() => _AddQuestionScreenState();
// }
//
// class _AddQuestionScreenState extends State<AddQuestionScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController questionController = TextEditingController();
//   final TextEditingController option1Controller = TextEditingController();
//   final TextEditingController option2Controller = TextEditingController();
//   final TextEditingController option3Controller = TextEditingController();
//   final TextEditingController option4Controller = TextEditingController();
//   final TextEditingController answerController = TextEditingController();
//
//   void _saveQuestion() async {
//     if (_formKey.currentState!.validate()) {
//       await DatabaseHelper.instance.insertQuestion({
//         'question': questionController.text,
//         'option1': option1Controller.text,
//         'option2': option2Controller.text,
//         'option3': option3Controller.text,
//         'option4': option4Controller.text,
//         'answer': answerController.text,
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Question Added')));
//       questionController.clear();
//       option1Controller.clear();
//       option2Controller.clear();
//       option3Controller.clear();
//       option4Controller.clear();
//       answerController.clear();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorResources.primary,
//       appBar: AppBar(title: Text("Add Question",),backgroundColor: ColorResources.primary,),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 TextFormField(controller: questionController, decoration: InputDecoration(labelText: 'Question')),
//                 TextFormField(controller: option1Controller, decoration: InputDecoration(labelText: 'Option 1')),
//                 TextFormField(controller: option2Controller, decoration: InputDecoration(labelText: 'Option 2')),
//                 TextFormField(controller: option3Controller, decoration: InputDecoration(labelText: 'Option 3')),
//                 TextFormField(controller: option4Controller, decoration: InputDecoration(labelText: 'Option 4')),
//                 TextFormField(controller: answerController, decoration: InputDecoration(labelText: 'Correct Answer')),
//                 SizedBox(height: 20),
//                 Container(
//                   width: double.infinity,
//                   child: ElevatedButton(onPressed: _saveQuestion,  style: ElevatedButton.styleFrom(
//                     backgroundColor: ColorResources.secondry,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//                     elevation: 5,
//                   ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(Icons.save, color: Colors.white),
//                         SizedBox(width: 8),
//                         Text(
//                           "Save Question",
//
//                           style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
