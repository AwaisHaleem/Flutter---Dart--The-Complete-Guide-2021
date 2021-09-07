import 'package:flutter/material.dart';

class Textt extends StatelessWidget {
  final String textt;

  Textt(this.textt);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 30),
      child: Text(
        textt,
        style: TextStyle(
          fontSize: 20,
          color: Colors.blueAccent,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
