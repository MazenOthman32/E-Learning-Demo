import 'package:Growing_Minds/Resources/color_resources.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ResultsView extends StatefulWidget {
  final int score;
  final int total;

  ResultsView({required this.score, required this.total});

  @override
  _ResultsViewState createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  late ConfettiController _confettiController;
  bool isPassed = false;

  @override
  void initState() {
    super.initState();
    isPassed = widget.score >= (widget.total / 2);
    _confettiController = ConfettiController(duration: Duration(seconds: 3));

    if (isPassed) _confettiController.play();

    _saveResultToFirestore();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _saveResultToFirestore() async {
    await FirebaseFirestore.instance.collection('quiz_results').add({
      'score': widget.score,
      'total': widget.total,
      'timestamp': Timestamp.now(),
      'status': isPassed ? 'Passed' : 'Failed',
    });
  }

  @override
  Widget build(BuildContext context) {
    Color scoreColor = isPassed ? Colors.green : Colors.red;
    String heading = isPassed ? "Congratulations!" : "Don't Give Up!";
    String message =
        isPassed ? "Great job! You Did It" : "Thank you! Try Again";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.primary,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: ColorResources.primary,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    value: widget.score / widget.total,
                    strokeWidth: 10,
                    valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
                    backgroundColor: Colors.white30,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "${widget.score} / ${widget.total}",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: scoreColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    heading,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: scoreColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    message,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/studentMainView',
                      );
                    },
                    icon: Icon(Icons.home, color: Colors.white),
                    label: Text(
                      "Back to Home",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorResources.secondry,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/quiz');
                    },
                    icon: Icon(Icons.replay, color: Colors.white),
                    label: Text(
                      "Try Again",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorResources.secondry,
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
          if (isPassed)
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: pi / 2,
                maxBlastForce: 10,
                minBlastForce: 5,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                gravity: 0.3,
              ),
            ),
        ],
      ),
    );
  }
}

// import 'package:Growing_Minds/Resources/color_resources.dart';
// import 'package:flutter/material.dart';
//
// class ResultsView extends StatelessWidget {
//   final int score;
//   final int total;
//
//   final String subject;
//
//   ResultsView({
//     required this.score,
//     required this.total,
//     required this.subject,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     bool isPassed = score >= (total / 2);
//     Color scoreColor = isPassed ? Colors.green : Colors.red;
//     String message =
//         isPassed ? "Great job! You Did It" : "Thank you! Try Again";
//     String heading = isPassed ? "Congratulations!" : "Don't Give Up!";
//     IconData icon = isPassed ? Icons.emoji_events : Icons.refresh;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorResources.primary,
//         automaticallyImplyLeading: false,
//         elevation: 0,
//       ),
//       backgroundColor: ColorResources.primary,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, size: 80, color: scoreColor),
//               SizedBox(height: 20),
//               Text(
//                 "Subject: $subject",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: scoreColor,
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               SizedBox(height: 20),
//               Text(
//                 "$score / $total",
//                 style: TextStyle(
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                   color: scoreColor,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 heading,
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.w600,
//                   color: scoreColor,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 message,
//                 style: TextStyle(fontSize: 16, color: Colors.black87),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 40),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.pushReplacementNamed(context, '/studentMainView');
//                 },
//                 icon: Icon(Icons.home, color: Colors.white),
//                 label: Text("Back to Home", style: TextStyle(fontSize: 18)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: ColorResources.secondry,
//                   minimumSize: Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.pushReplacementNamed(context, '/quiz');
//                 },
//                 icon: Icon(Icons.replay, color: Colors.white),
//                 label: Text("Try Again", style: TextStyle(fontSize: 18)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: ColorResources.secondry,
//                   minimumSize: Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
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
