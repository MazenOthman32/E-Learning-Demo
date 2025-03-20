import 'package:Growing_Minds/Resources/color_resources.dart';
import 'package:flutter/material.dart';

class StudentProfileView extends StatelessWidget {
  const StudentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primary,
      body: Center(
        child: ElevatedButton(onPressed: ()=>Navigator.pushReplacementNamed(context, '/login'), child: Text('Log Out')),
      ),
    );
  }
}
