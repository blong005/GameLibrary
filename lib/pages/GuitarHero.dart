import 'package:flutter/material.dart';

class GuitarHero extends StatelessWidget {
  
  final String pageText;

  GuitarHero(this.pageText);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: RichText(text: TextSpan(  
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan> [
            TextSpan(  
              text: "Guitar Hero Coming Soon. \n",
              style: TextStyle(color: Colors.white)
            )
          ]
        ),)
      )
    );
  }
}