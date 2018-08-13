import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter/material.dart';
import 'landing_page.dart';
class ScorePage extends StatelessWidget{
  final int score;
  final int totalQuestion;
  final String subject;
  final String username="ganesh";

  ScorePage(this.score,this.totalQuestion,this.subject);

  void databaseTransaction() async {
    //getting path
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "QuizApp.db");

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table

      await db.execute(
          "CREATE TABLE Scores (matchid INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,category TEXT, score INTEGER)");
    });

    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Scores ( name, category, score) VALUES("$username","$subject", $score)');
      print("inserted: $id1");
    });

  }

  @override
    Widget build(BuildContext context) {
      databaseTransaction();
      // TODO: implement build
      return new Material(
        color: Colors.blue,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Your Score Is ",style: new TextStyle(color: Colors.white,fontSize: 50.0,fontWeight: FontWeight.bold),),
            new Text(score.toString()+"/"+totalQuestion.toString(),style: new TextStyle(color: Colors.white,fontSize: 50.0,fontWeight: FontWeight.bold),),
            new IconButton(
              icon: new Icon(Icons.arrow_right),
              iconSize: 50.0,
              onPressed: () => Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context)=>new LandingPage()))
            )
          ],
        ),
      );
    }
}