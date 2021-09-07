import 'package:flutter/material.dart';
import 'quiz.dart';
import 'result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final questions = const [
    {
      "Question Text": "What's your fav color",
      "Answer": [
        {"text": "Black", "score": 10},
        {"text": "White", "score": 0},
        {"text": "Brown", "score": 5},
        {"text": "Red", "score": 7}
      ]
    },
    {
      "Question Text": "What's your fave animal",
      "Answer": [
        {"text": "Rabit", "score": 0},
        {"text": "Cow", "score": 2},
        {"text": "Horse", "score": 5},
        {"text": "Cat", "score": 7}
      ]
    },
    {
      "Question Text": "What's your fav teacher",
      "Answer": [
        {"text": "Max", "score": 0},
        {"text": "Mack", "score": 0},
        {"text": "Mill", "score": 0},
        {"text": "Miller", "score": 0}
      ]
    },
  ];
  var _totalscore = 0;
  var _questionIndex = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalscore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalscore += score;
    setState(() {
      _questionIndex += 1;
    });
    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Quiz App"),
          centerTitle: true,
        ),
        body: Container(
          child: _questionIndex < questions.length
              ? Quiz(
                  qusetions: questions,
                  qusetionIndex: _questionIndex,
                  answerQuestion: _answerQuestion)
              : Result(
                  _totalscore, _resetQuiz),
        ),
      ),
    );
  }
}
