import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayer/audioplayer.dart';


class Snake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SnakeApp());
  }
}

class SnakeApp extends StatefulWidget {
  @override
  _SnakeAppState createState() => _SnakeAppState();
}

enum musicState {playing, stopped}          //music player states

class _SnakeAppState extends State<SnakeApp> {
  String mp3uri= '';

  void startMusic(){
    AudioPlayer player = AudioPlayer();
    player.play(mp3uri);
  }


  final int numSquaresRow = 10; //grid size dimensions
  final int numSquaresCol = 20;
  var snake = [
    [0, 1],
    [0, 0]
  ]; //snake start position of size 2 units
  var apple = [0, 5]; //start pos of food
  bool inGame = false; //flag signals movement
  var direction = "down"; //movement direction

  var randomGenerator = Random();

  void loadmp3() async{                                  //load in mp3 file before game start, must be called in initstate
    final ByteData data = await rootBundle.load('assets/ACNHBUBBLEGUMLIVE.mp3');
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/BUBBLEGUMLIVE.mp3');
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    mp3uri = tempFile.uri.toString();
  }

  void startGame() {
    loadmp3();
    startMusic();
    const duration = Duration(milliseconds: 150); //movement speed
    snake = [
      [(numSquaresRow / 2).floor(), (numSquaresCol / 2).floor()] //snake head
    ];

    snake.add([snake.first[0], snake.first[1] - 1]); //snake body

    spawnApple();
    inGame = true;
    Timer.periodic(duration, (Timer timer) {
      moveSnake();
      if (checkCrash()) {
        timer.cancel();
        endGame();
      }
    });
  }

  bool checkCrash() {
    //checks for game ending conditions
    if (!inGame || //in game flag not high
            snake.first[1] < 0 || //snake head not in vertical boundary
            snake.first[1] > numSquaresCol - 1 ||
            snake.first[0] < 0 || //snake head not in horizontal boundary
            snake.first[0] > numSquaresRow - 1 ||
            checkSelfCrash() //snake crashes into body
        ) {
      return true;
    }
    return false;
  }

  bool checkSelfCrash() {
    //snake.add([snake.first[0], snake.first[1] - 1]);
    bool isBody = false;

    for (int i = 0; i < snake.length; i++) {
      if (isBody) {
        return true;
      }
    }
    return false;
  }

  void endGame() {
    inGame = false;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Game Over'),
              content: Text('Score: ${snake.length - 2}',
                  style: TextStyle(fontSize: 20)));
        });
  }

  void moveSnake() {
    setState(() {
      switch (direction) {
        case 'left':
          snake.insert(0, [snake.first[0] - 1, snake.first[1]]);
          break;

        case 'right':
          snake.insert(0, [snake.first[0] + 1, snake.first[1]]);
          break;

        case 'up':
          snake.insert(0, [snake.first[0], snake.first[1] - 1]);
          break;

        case 'down':
          snake.insert(0, [snake.first[0], snake.first[1] + 1]);
          break;
      }

      if (snake.first[0] != apple[0] || snake.first[1] != apple[1]) {
        snake.removeLast();
      } else {
        spawnApple();
      }
    });
  }

  void spawnApple() {
    apple = [
      randomGenerator.nextInt(numSquaresRow),
      randomGenerator.nextInt(numSquaresCol),
    ];
  }

  @override
  void initState() {              //init state to load mp3 file
    super.initState();
    loadmp3();
    startMusic();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      //DragUpdate for User Input Game Control
                      if (direction != 'up' && details.delta.dy > 0) {
                        direction = 'down';
                      } else if (direction != 'down' && details.delta.dy < 0) {
                        direction = 'up';
                      }
                    },
                    onHorizontalDragUpdate: (details) {
                      if (direction != 'left' && details.delta.dx > 0) {
                        direction = 'right';
                      } else if (direction != 'right' && details.delta.dx < 0) {
                        direction = 'left';
                      }
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AspectRatio(
                        aspectRatio: numSquaresRow / (numSquaresCol + 2), //Aspect Ratio: width / height , uses double
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: numSquaresRow,
                            ),
                            itemCount: numSquaresRow * numSquaresCol,
                            itemBuilder: (BuildContext context, int index) {
                              bool isBody = false;
                              //calculate x and y pos of body
                              var x = index % numSquaresRow; 
                              var y = (index / numSquaresRow).floor();
                              //Checking snake body
                              for (var pos in snake) {
                                if (pos[0] == x && pos[1] == y) {
                                  isBody = true;
                                  break;
                                }
                              }
                              //Applying color to snake body, apple, and map
                              var color;
                              if (snake.first[0] == x && snake.first[1] == y) {
                                color = Colors.greenAccent;
                              } else if (isBody) {
                                color = Colors.green[200];
                              } else if (apple[0] == x && apple[1] == y) {
                                color = Colors.red;
                              } else {
                                color = Colors.grey[200];
                              }

                              //return container for item build
                              return Container(
                                margin: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    color: color,
                                    //color: Colors.yellow[100],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2.0, color: Colors.white)),
                              );
                            }),
                      ),
                    ))),
            Row(
              //start button
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.indigo[100],
                  child: Text('Start'),
                  onPressed: () {
                    if (inGame) {
                      inGame = false;
                    } else {
                      startGame();

                    }
                  },
                ),
                FlatButton(
                  //ScoreBoard
                  color: Colors.indigo[100],
                  child: Text('Score: ${snake.length - 2}'),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ));
  }
}
