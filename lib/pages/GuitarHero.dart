import 'package:flutter/material.dart';

class GuitarHero extends StatelessWidget {
  
  final String pageText;

  GuitarHero(this.pageText);

  
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