import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateClassDialog extends StatelessWidget {
  final TextEditingController subjectController;
  final Function(String, DateTime, TimeOfDay) onClassCreated;

  const CreateClassDialog({required this.subjectController, required this.onClassCreated});

  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    return AlertDialog(
      title: Text("Create Upcoming Class", style: GoogleFonts.poppins()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: subjectController, decoration: InputDecoration(labelText: "Subject")),
          ElevatedButton(onPressed: () async {
            selectedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2101));
          }, child: Text("Select Date")),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
      ],
    );
  }
}
