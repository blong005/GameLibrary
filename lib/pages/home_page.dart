import 'package:GameLibrary/pages/GuitarHero.dart';
import 'package:flutter/material.dart';
import './TicTacToe.dart';
import './Snake.dart';
import './GuitarHero.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

String mainProfilePicture = "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTaRfDgknGmMT7gJRyrVXvRWG0S-7sNqszmCcRL9E7wtRt-Kl7_&usqp=CAU";
String otherProfilePicture = "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSabxAgg_xMG1IQ7HoK18SEjIVpTaythWjU4nQ2fAqbycREyV7i&usqp=CAU";
String otherProfilePicture2 = "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSxgzgNMDitMIeVgBnMg6Yl_b335BJDQW0k3dcuaV90H0335Oku&usqp=CAU";

void switchUser(int x){
  String backupString = mainProfilePicture;
  if(x == 1){
    this.setState(() {
    mainProfilePicture = otherProfilePicture;
    otherProfilePicture = backupString;
    });
  }
  if(x == 2){
    this.setState(() {
    mainProfilePicture = otherProfilePicture2;
    otherProfilePicture2 = backupString;
    });
  }
}
 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Game Library"),
      backgroundColor: Colors.redAccent,),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("benlo"), 
              accountEmail: new Text("benlo@gmail.com"),
              currentAccountPicture: new GestureDetector(
                onTap: () => print("This is the current user"),
                child: new CircleAvatar(backgroundImage: new NetworkImage(mainProfilePicture),)
              ),
              otherAccountsPictures: <Widget>[
                new GestureDetector(
                onTap: () => switchUser(1),
                child: new CircleAvatar(backgroundImage: new NetworkImage(otherProfilePicture),)
              ),
              new GestureDetector(
                onTap: () => switchUser(2),
                child: new CircleAvatar(backgroundImage: new NetworkImage(otherProfilePicture2),)
              ),
              ],
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage("https://i2.wp.com/techacute.com/wp-content/uploads/2018/09/psx_20180927_1632497300034299043957445.jpg?resize=696%2C392&ssl=1"),
                  fit: BoxFit.fill,
                  )
              ),
              ),
            new ListTile(
              title: new Text("TicTacToe"),
              trailing: new Icon(Icons.play_circle_outline),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new TicTacToe("TicTacToe"))),
            ),
            new ListTile(
              title: new Text("Snake"),
              trailing: new Icon(Icons.play_circle_outline),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Snake("Snake"))),
            ),
            new ListTile(
              title: new Text("Guitar Hero"),
              trailing: new Icon(Icons.play_circle_outline),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new GuitarHero("Guitar Hero"))),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Close"),
              trailing: new Icon(Icons.cancel),
              onTap: () => Navigator.of(context).pop(),
            ),
          ]
          ,)
      ),
      body: new Center(
        child: new Text("Let's Play a Game",
          style: new TextStyle(fontSize: 35.0)),
      ),
    );
  }
}
