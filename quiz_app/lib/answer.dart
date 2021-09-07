import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback callBack;
  final String text;
  Answer(
    this.callBack, this.text
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white)),
        onPressed: callBack,
        child: Text(text),
      ),
    );
  }
}
