import 'package:flutter/material.dart';

class TextController extends StatelessWidget {
  final VoidCallback _controller;
  TextController(this._controller);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: _controller, child: Text("Change Text"));
  }
}
