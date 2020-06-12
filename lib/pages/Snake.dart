import 'package:flutter/material.dart';
//import 'dart:math';
//import 'dart:async';



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

  final int numSquaresRow = 10;       //grid size dimensions
  final int numSquaresCol= 20;
  var snake = [[0,1], [0,0]];         //snake start position of size 2 units
  var apple = [0, 5];                 //start pos of food
  bool inGame = false;                //flag signals movement
  var dir = "down";                   //movement direction

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.brown[400],
     body: Column(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            child: AspectRatio(
              aspectRatio: numSquaresRow / numSquaresCol,             //Aspect Ratio: width / height , uses double
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numSquaresRow,
                ),
                itemCount: numSquaresRow * numSquaresCol,
                itemBuilder: (BuildContext context, int index) {

                  bool isBody = false;

                  var x = index % numSquaresRow;
                  var y = (index / numSquaresRow).floor();

                  //Identifying snake body
                  for (var pos in snake){
                    if ( pos[0] == x && pos[1] == y){
                      isBody = true;
                      break;
                    }
                  }

                  //Applying color to snake body, apple, and map
                  var color;
                  if (snake.first[0] == x && snake.first[1] == y) {
                    color = Colors.greenAccent;
                  }
                  else if(isBody) {
                    color = Colors.green[200];
                  }
                  else if(apple[0] == x && apple[1] == y) {
                    color = Colors.red;
                  }
                  else{
                    color = Colors.grey[200];
                  }

                  //return container for build
                  return Container(
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(  
                      color: color,
                      //color: Colors.yellow[100],
                      shape: BoxShape.circle,
                      border: Border.all(width: 5.0, color: Colors.white)
                    ),
                    // child: Padding(
                    //   padding: EdgeInsets.all(8),
                    //   child: Container(
                    //     width: 20,
                    //     height: 20,
                    //     decoration: new BoxDecoration(  
                    //       color: Colors.white54,
                    //       shape: BoxShape.circle,
                    //     )
                    //   ),
                    //   ),
                  );
                }
              ),
            )
          )
        )
       ],
     )
    );
  }
}