import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final VoidCallback resetTest;

  Result(this.totalScore, this.resetTest);

  String get resultPhrase {
    String resultText;
    if (totalScore <= 8) {
      resultText = "You're innocent and awesome";
    } else if (totalScore <= 12) {
      resultText = "Pretty Likeable";
    } else if (totalScore <= 16) {
      resultText = "You're ... Strange";
    } else {
      resultText = "You're so bad";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        // ElevatedButton(
        //   onPressed: resetTest,
        //   child: Text("Restart Quiz"),
        //   style: ButtonStyle(
        //     backgroundColor: MaterialStateProperty.all(Colors.white),
        //     foregroundColor: MaterialStateProperty.all(Colors.blue),
        //   ),
        // ),
        TextButton(
          onPressed: resetTest,
          child: Text("Restart Quiz"),
        )
      ],
    );
  }
}
