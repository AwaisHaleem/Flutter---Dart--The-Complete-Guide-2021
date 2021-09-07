import 'package:flutter/material.dart';
import 'textController.dart';
import 'text.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _text = const [
    "Hi! How are you doing",
    "I'm doing great",
    "We both are learning Mobile app development",
    "You're a bright student"
  ];

  int _textIndex = 0;

  void _changePhrase() {
    setState(() {
      _textIndex += 1;
    });
  }

  void _restartCycle() {
    setState(() {
      _textIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Assignment"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _textIndex < _text.length
                ? Textt(_text[_textIndex])
                : TextButton(
                    onPressed: _restartCycle,
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        "Restart",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
            TextController(_changePhrase)
          ],
        ),
      ),
    );
  }
}
