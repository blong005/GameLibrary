import 'package:flutter/material.dart';

class HighScores extends StatelessWidget {
  
  final String pageText;

  HighScores(this.pageText);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text(pageText),),
      body: new Center(
        child: new Text(pageText),
      ),
    );
  }
}