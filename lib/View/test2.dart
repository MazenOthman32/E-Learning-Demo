// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:lottie/lottie.dart';
//
// class TeacherDashboard extends StatefulWidget {
//   @override
//   _TeacherDashboardState createState() => _TeacherDashboardState();
// }
//
// class _TeacherDashboardState extends State<TeacherDashboard> {
//   int? selectedYear;
//   List<String> subjects = [];
//   String? selectedSubject;
//   List<Map<String, String>> upcomingClasses = [];
//
//   Map<int, List<String>> yearSubjects = {
//     1: ['Math', 'Science', 'English'],
//     2: ['Physics', 'Chemistry', 'Biology'],
//     3: ['History', 'Geography', 'Economics'],
//     4: ['Computer Science', 'Business Studies', 'Statistics'],
//   };
//
//   void createUpcomingClass() async {
//     TextEditingController subjectController = TextEditingController();
//     DateTime? selectedDate;
//     TimeOfDay? selectedTime;
//
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Create Upcoming Class", style: GoogleFonts.poppins()),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: subjectController,
//                 decoration: InputDecoration(labelText: "Subject"),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () async {
//                   DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime(2101),
//                   );
//                   if (pickedDate != null) {
//                     setState(() {
//                       selectedDate = pickedDate;
//                     });
//                   }
//                 },
//                 child: Text(
//                   selectedDate == null
//                       ? "Select Date"
//                       : "Date: ${selectedDate!.toLocal()}".split(' ')[0],
//                 ),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () async {
//                   TimeOfDay? pickedTime = await showTimePicker(
//                     context: context,
//                     initialTime: TimeOfDay.now(),
//                   );
//                   if (pickedTime != null) {
//                     setState(() {
//                       selectedTime = pickedTime;
//                     });
//                   }
//                 },
//                 child: Text(
//                   selectedTime == null
//                       ? "Select Time"
//                       : "Time: ${selectedTime!.format(context)}",
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (subjectController.text.isNotEmpty &&
//                     selectedDate != null &&
//                     selectedTime != null) {
//                   setState(() {
//                     upcomingClasses.add({
//                       "subject": subjectController.text,
//                       "date": "${selectedDate!.toLocal()}".split(' ')[0],
//                       "time": selectedTime!.format(context),
//                     });
//                   });
//                   Navigator.pop(context);
//                 }
//               },
//               child: Text("Create"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void selectYear(int year) {
//     setState(() {
//       selectedYear = year;
//       subjects = yearSubjects[year] ?? [];
//       selectedSubject = null;
//     });
//   }
//
//   void selectSubject(String subject) {
//     setState(() {
//       selectedSubject = subject;
//     });
//   }
//
//   void navigateToCreateQuiz() {
//     // Function to navigate to Create Quiz page
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple,
//         title: Text(
//           'Teacher Dashboard',
//           style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 16.0),
//             child: CircleAvatar(
//               backgroundImage: AssetImage('assets/avatar.png'),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             FadeInDown(
//               child: Text(
//                 'Select Year:',
//                 style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             FadeInUp(
//               child: Wrap(
//                 spacing: 10.0,
//                 children: List.generate(4, (index) {
//                   int year = index + 1;
//                   return ChoiceChip(
//                     label: Text('Year $year', style: GoogleFonts.poppins()),
//                     selected: selectedYear == year,
//                     onSelected: (selected) => selectYear(year),
//                     selectedColor: Colors.deepPurpleAccent,
//                   );
//                 }),
//               ),
//             ),
//             SizedBox(height: 20),
//             if (selectedYear != null) ...[
//               FadeInDown(
//                 child: Text(
//                   'Select Subject:',
//                   style: GoogleFonts.poppins(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemCount: subjects.length,
//                 itemBuilder: (context, index) {
//                   return BounceInUp(
//                     child: GestureDetector(
//                       onTap: () => selectSubject(subjects[index]),
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         color:
//                             selectedSubject == subjects[index]
//                                 ? Colors.deepPurpleAccent
//                                 : Colors.white,
//                         child: Center(
//                           child: Text(
//                             subjects[index],
//                             style: GoogleFonts.poppins(
//                               fontSize: 16,
//                               color:
//                                   selectedSubject == subjects[index]
//                                       ? Colors.white
//                                       : Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//             SizedBox(height: 20),
//             FadeInLeft(
//               child: Text(
//                 'Upcoming Classes',
//                 style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             ...upcomingClasses.map(
//               (classItem) => Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: ListTile(
//                   leading: Icon(Icons.schedule, color: Colors.deepPurple),
//                   title: Text(
//                     classItem['subject']!,
//                     style: GoogleFonts.poppins(),
//                   ),
//                   subtitle: Text(
//                     '${classItem['date']} at ${classItem['time']}',
//                   ),
//                 ),
//               ),
//             ),
//
//             Padding(
//               padding: const EdgeInsets.only(bottom: 32.0 ,top: 16),
//               child: CircleAvatar(
//                 backgroundColor: Colors.black26,
//                 child: IconButton(
//                   onPressed: createUpcomingClass,
//                   icon: Icon(Icons.add , color: Colors.white,),
//                 ),
//               ),
//             ),
//
//             if (selectedSubject != null)
//               FadeIn(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     ElevatedButton(
//                       onPressed: navigateToCreateQuiz,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepPurpleAccent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//                         elevation: 5,
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.quiz, color: Colors.white),
//                           SizedBox(width: 8),
//                           Text(
//                             "Create Quiz",
//                             style: GoogleFonts.poppins(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Spacer(),
//                     ElevatedButton(
//                       onPressed: navigateToCreateQuiz,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepPurpleAccent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//                         elevation: 5,
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.quiz, color: Colors.white),
//                           SizedBox(width: 8),
//                           Text(
//                             "Create Quiz",
//                             style: GoogleFonts.poppins(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
