import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';



class Snake extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SnakeApp()
    );
  }
}

class SnakeApp extends StatefulWidget {
  @override
  _SnakeAppState createState() => _SnakeAppState();
}

class _SnakeAppState extends State<SnakeApp> {

  final int numSquaresRow = 20;
  final int numSquaresCol= 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: RichText(text: TextSpan(  
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan> [
            TextSpan(  
              text: "Snake Coming Soon. \n",
              style: TextStyle(color: Colors.white)
            )
          ]
        ),)
      )
    );
  }
}