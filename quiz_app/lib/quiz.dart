import 'package:flutter/material.dart';
import 'question.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> qusetions;
  final int qusetionIndex;
  final Function answerQuestion;

  Quiz({
    required this.qusetions,
    required this.qusetionIndex,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(qusetions[qusetionIndex]["Question Text"] as String),
        ...(qusetions[qusetionIndex]["Answer"] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerQuestion(answer['score']),
              answer["text"] as String);
        }).toList()
      ],
    );
  }
}
