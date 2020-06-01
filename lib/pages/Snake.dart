import 'package:flutter/material.dart';

class Snake extends StatelessWidget {
  
  final String pageText;

  Snake(this.pageText);

  
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