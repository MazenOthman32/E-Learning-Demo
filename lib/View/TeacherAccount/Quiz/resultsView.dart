import 'package:Growing_Minds/Resources/color_resources.dart';
import 'package:flutter/material.dart';

class ResultsView extends StatelessWidget {
  final int score;
  final int total;

  ResultsView({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    bool isPassed = score >= (total / 2);
    Color scoreColor = isPassed ? Colors.green : Colors.red;
    String message = isPassed ? "Great job! You Did It" : "Thank you! Try Again";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.primary,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: ColorResources.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black26,
                ),
                child: Center(
                  child: Text(
                    "$score/$total",
                    style: TextStyle(
                      color: scoreColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text( isPassed ?
              "Congratulation" : "Don't give up" ,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color:  isPassed ?  Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: 10),
              Text(
                message,
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: (){  Navigator.pushReplacementNamed(context, '/studentMainView');
                },
                child: Text("Back To Home", style: TextStyle(fontSize: 18,color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.secondry,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/quiz');
                },
                child: Text("Try Again", style: TextStyle(fontSize: 18,color: Colors.white)),
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
      ),
    );
  }
}
