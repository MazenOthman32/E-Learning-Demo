import 'package:Growing_Minds/View/TeacherAccount/Quiz/QuestionListScreen.dart';
import 'package:Growing_Minds/View/TeacherAccount/Quiz/addQuestionsScreen.dart';
import 'package:Growing_Minds/View/TeacherAccount/Quiz/editQuestionScreen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Resources/color_resources.dart';

class TeacherDashboardView extends StatefulWidget {
  @override
  _TeacherDashboardViewState createState() => _TeacherDashboardViewState();
}

class _TeacherDashboardViewState extends State<TeacherDashboardView> {
  int? selectedYear;
  List<String> subjects = [];
  String? selectedSubject;
  List<Map<String, String>> upcomingClasses = [];

  final Map<int, List<String>> yearSubjects = {
    1: ['Math 1', 'Arabic 1', 'English 1'],
    2: ['Math 2', 'Arabic 2', 'English 2'],
    3: ['Math 3', 'Arabic 3', 'English 3'],
    4: ['Math 4', 'Social Study 1', 'Arabic 4', 'English 4', 'Science 1'],
  };
  void navigateToAddToQuiz() {
Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuestionScreen(),));
  }
  void navigateToEditToQuiz() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionListScreen(),));
  }

  void selectYear(int year) {
    setState(() {
      selectedYear = year;
      subjects = yearSubjects[year] ?? [];
      selectedSubject = null;
    });
  }

  void selectSubject(String subject) {
    setState(() {
      selectedSubject = subject;
    });
  }

  void createUpcomingClass() async {
    TextEditingController subjectController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return CreateClassDialog(
          subjectController: subjectController,
          onClassCreated: (subject, date, time) {
            setState(() {
              upcomingClasses.add({
                "subject": subject,
                "date": "${date.toLocal()}".split(' ')[0],
                "time": time.format(context),
              });
            });
          },
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorResources.secondry,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Good Evening",
                  style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  "Mr. Ahmed Reda",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
            Builder( // This ensures the correct context is used
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: Icon(Icons.menu, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorResources.primary,
      endDrawer: Drawer(
width: 200,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: ColorResources.secondry),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () =>  Navigator.pushReplacementNamed(context, '/login')
              ,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            _buildHeader(context),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(
                    child: Text(
                      "Select Grade",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  FadeInDown(
                    child: Text(
                      "Put Your Questions And Manage it !",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  FadeInUp(
                    child: Wrap(
                      spacing: 10.0,
                      children: List.generate(4, (index) {
                        int year = index + 1;
                        return ChoiceChip(
                          label: Text(
                            'Grade $year',
                            style: GoogleFonts.poppins(),
                          ),
                          selected: selectedYear == year,
                          onSelected: (selected) => selectYear(year),
                          selectedColor: ColorResources.secondry,
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (selectedYear != null) ...[
                    FadeInDown(
                      child: Text(
                        "Select Subject",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    SubjectGrid(
                      subjects: subjects,
                      selectedSubject: selectedSubject,
                      onSelect: selectSubject,
                    ),
                  ],
                  SizedBox(height: 20),
                  FadeInLeft(
                    child: Text(
                      "Upcoming Classes",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  UpcomingClassesList(classes: upcomingClasses),
                  SizedBox(height: 16),
                  FloatingActionButton(
                    backgroundColor: ColorResources.secondry,
                    onPressed: createUpcomingClass,
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                  if (selectedSubject != null) SizedBox(height: 16),
                  if (selectedSubject != null)
                    FadeIn(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: navigateToAddToQuiz,
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
                                  Icon(Icons.quiz, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    "Add Questions To Quiz",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 15),
                            ElevatedButton(
                              onPressed: navigateToEditToQuiz,
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
                                  Icon(
                                    Icons.manage_history_sharp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Mangage Quiz",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}

/// **Subject Grid Widget**
class SubjectGrid extends StatelessWidget {
  final List<String> subjects;
  final String? selectedSubject;
  final Function(String) onSelect;

  const SubjectGrid({
    required this.subjects,
    required this.selectedSubject,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        return BounceInUp(
          child: GestureDetector(
            onTap: () => onSelect(subjects[index]),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color:
                  selectedSubject == subjects[index]
                      ? ColorResources.secondry
                      : Colors.white,
              child: Center(
                child: Text(
                  subjects[index],
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color:
                        selectedSubject == subjects[index]
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// **Upcoming Classes List Widget**
class UpcomingClassesList extends StatelessWidget {
  final List<Map<String, String>> classes;
  const UpcomingClassesList({required this.classes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          classes
              .map(
                (classItem) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.schedule, color: Colors.deepPurple),
                    title: Text(
                      classItem['subject']!,
                      style: GoogleFonts.poppins(),
                    ),
                    subtitle: Text(
                      '${classItem['date']} at ${classItem['time']}',
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}

/// **Create Class Dialog Widget**
class CreateClassDialog extends StatelessWidget {
  final TextEditingController subjectController;
  final Function(String, DateTime, TimeOfDay) onClassCreated;

  const CreateClassDialog({
    required this.subjectController,
    required this.onClassCreated,
  });

  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    return AlertDialog(
      backgroundColor: Colors.black26,
      title: Text(
        "Create Upcoming Class",
        style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: subjectController,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white,
            ), // Style for typed text
            cursorColor: Colors.white, // Set cursor color
            decoration: InputDecoration(
              labelText: "Subject",
              labelStyle: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
              ),
              hintStyle: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
              floatingLabelStyle: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
              ),
              focusColor: Colors.white,
              hoverColor: Colors.white,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
              },
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
                  Icon(Icons.date_range, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Select Date",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
              },
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
                  Icon(Icons.timer, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Select Time",
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
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            elevation: 5,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cancel, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "Cancel",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (subjectController.text.isNotEmpty &&
                selectedDate != null &&
                selectedTime != null) {
              onClassCreated(
                subjectController.text,
                selectedDate!,
                selectedTime!,
              );
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            elevation: 5,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.create, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "Create",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
