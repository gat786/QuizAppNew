import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:quiz/ui/score_card.dart';
import 'package:quiz/util/category_model.dart';

int totalScore=0;
int totalMatches=0;


class PersonalScore extends StatefulWidget{

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return PersonalScoreState();
    }
}
List subjects;
int getNumOfCategories(List list){
  CategoryModel model=new CategoryModel();
  for (var a in list){
    var name=model.categoryName(int.parse( a["category"]));
    if(subjects.contains(name)!=true){
      subjects.add(name);
    }
  }
  return subjects.length;
}




    List<Widget> scorecards=[];
    void buildCards(){
      scorecards=[];
      for (var a in subjects){
        List scoreCardDetail=totalGetter(list, a);
        print(scoreCardDetail);
        var scorecard=returnCard(a, scoreCardDetail[0].toString(), scoreCardDetail[1].toString());
        scorecards.add(scorecard);
      }
      
    }

    Widget returnCard(String subName, String score,String matches){
      var card =  new Column(
          children: <Widget>[
            new Container(child: new Text("$subName Scores",textAlign: TextAlign.center,style: new TextStyle(fontSize: 20.0),),padding: EdgeInsets.all(10.0),),
            new ScoreCard(int.parse(matches), int.parse(score)),
          ],
        );
      return card;
    }
    

    
    List totalGetter(list,subName){
      var score=0,matches=0;
      CategoryModel model=new CategoryModel();
      for(var a in list){
        if (a["category"]==model.categoryNumber(subName).toString()){
          score=a["score"]+score;
          matches=matches+1;
        }
      }
      return [score,matches];
    }
 

   

List<Map> list;

class PersonalScoreState extends State<PersonalScore>{
    PersonalScoreState(){
      getScore();
    }

    void getScore() async {
      totalScore=0;
      var databases=await getDatabasesPath();
      String path=join(databases,"QuizApp.db");

      Database database = await openDatabase(path, version: 1,
            onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              "CREATE TABLE Scores (matchid INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,category TEXT, score INTEGER)");
        });

      list=await database.rawQuery("Select * from Scores");
      for(var a in list){
        totalScore=totalScore+a["score"];
      }
      print(list);
      totalMatches=list.length;
      getNumOfCategories(list);
      buildCards();
      this.setState((){
        totalScore=totalScore;
        totalMatches=totalMatches;
      }
      );
    }

  


    @override
    Widget build(BuildContext context) {
      subjects=[];
      // TODO: implement build
      return new Scaffold(
        body: new Material(
            child:new Padding(
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: new ListView(
                children: <Widget>[
                  new Container(child: new Text("OverAll Scores",textAlign: TextAlign.center,style: new TextStyle(fontSize: 20.0),),padding: EdgeInsets.all(10.0),),
                  new ScoreCard(totalMatches, totalScore),
                  new Column(
                    children: scorecards,
                  )
                ],
              )
            )
          )
      );
    }
}