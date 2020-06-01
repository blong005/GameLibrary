import 'package:flutter/material.dart';

class TicTacToe extends StatelessWidget {
  
  final String pageText;

  TicTacToe(this.pageText);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TTTPage(),
    );
  }
}

class TTTPage extends StatefulWidget {
  @override
  _TTTPageState createState() => _TTTPageState();
}

class _TTTPageState extends State<TTTPage> {

    List<String> displayXO = [
    '','','',
    '','','',
    '','',''];
  bool oTurn = true; //O player goes first

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,//removes degugger flag in emulator
          home: Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text('TicTacToe', 
                style: TextStyle(
                  fontStyle: FontStyle.italic
                )),
              ),
              ),
        backgroundColor: Colors.grey[800],
        body: GridView.builder(
          gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),//sliver grid creates unlimited scroll grid, crossaxiscount defines column width
            itemCount: 9,                                               //defines num items in grids
        itemBuilder: (BuildContext context, int index){       //index keeps track of which grid is written to 
          return GestureDetector(    //Tap gesture
            onTap: (){
              _tapped(index);   //calls tap function, passes index for grid display x or o
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[700])
              ),
              child: Center( 
                child: Text(displayXO[index], style: TextStyle(color: Colors.lightBlueAccent, fontSize: 40),),
                ),
            ),
          );
        })
      ),
    );
  } 

  void _tapped(int index) {
      setState(() {
        if(oTurn == true && displayXO[index] == ''){    //so players do not overwrite eachother
          displayXO[index] = 'O';
          oTurn = !oTurn; //alternate turn
          //display player turn dialog
        }
        if(oTurn == false && displayXO[index] == ''){
          displayXO[index] = 'X';
          oTurn = !oTurn; //alternate turn
        }
        checkWin();
      });
    } //TAPPED

  void checkWin(){
    //cases
    if(displayXO[0] == displayXO[1] &&  //first row
      displayXO[1] == displayXO[2] && 
      displayXO[0] != ''){
      _showWinDialog();
    }

    else if(displayXO[3] == displayXO[4] &&  //second row
      displayXO[4] == displayXO[5] && 
      displayXO[3] != ''){
      _showWinDialog();
    }

    else if(displayXO[6] == displayXO[7] &&  //third row
      displayXO[7] == displayXO[8] && 
      displayXO[6] != ''){
      _showWinDialog();
    }

    else if(displayXO[0] == displayXO[3] &&  //first col
      displayXO[3] == displayXO[6] && 
      displayXO[0] != ''){
      _showWinDialog();
    }

    else if(displayXO[1] == displayXO[4] &&  //sec col
      displayXO[4] == displayXO[7] && 
      displayXO[1] != ''){
      _showWinDialog();
    }

    else if(displayXO[2] == displayXO[5] &&  //third col
      displayXO[5] == displayXO[8] && 
      displayXO[2] != ''){
      _showWinDialog();
    }

    else if(displayXO[0] == displayXO[4] &&  //backward diagonal
      displayXO[4] == displayXO[8] && 
      displayXO[0] != ''){
      _showWinDialog();
    }

    else if(displayXO[6] == displayXO[4] &&  //forward diagonal
      displayXO[4] == displayXO[2] && 
      displayXO[6] != ''){
      _showWinDialog();
    }

    else if(                  //tie game when everything is filled with no found matches
      displayXO[0] !=''&&       
      displayXO[1] !=''&&
      displayXO[2] !=''&&
      displayXO[3] !=''&&
      displayXO[4] !=''&&
      displayXO[5] !=''&&
      displayXO[6] !=''&&
      displayXO[7] !=''&&
      displayXO[8] !=''){
        _showTieDialog();
      }
  } //CHECKWIN

  void _showWinDialog(){
    showDialog(
      context: context,
      builder: 
      (BuildContext context)
      {
        return AlertDialog(
          title: Center(
            child: Text('Winner! Tap anywhere to restart...',
              style: TextStyle(
                color: Colors.green[800]
              ),
            ),
          ),
          backgroundColor: Colors.lightGreenAccent,
        );
      }
    );
    //call reset function here, game is now over
    _reset(displayXO);
  } //SHOWWINDIALOG

 void _showTieDialog(){
    showDialog(
      context: context,
      builder: 
      (BuildContext context)
      {
        return AlertDialog(
          title: Center(
            child: Text('You both suck at this game. Tap anywhere to restart...',
              style: TextStyle(
                color: Colors.red[800]
              ),
            ),
          ),
          backgroundColor: Colors.white,
        );
      }
    );
    _reset(displayXO);
  } //_SHOWTIEDIALOG

  void _reset(List<String> list){ //clear grid for new game
    for(int i = 0; i < 9; i++){
      list[i] = '';
    }
  }
}