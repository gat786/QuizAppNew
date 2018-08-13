import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget{
  final int totalScore;
  final int totalMatches;

  ScoreCard(this.totalMatches,this.totalScore);


  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Material(
        child: new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: new Card(
            elevation: 5.0,
            color: Colors.blue,
            child: new Container(
              width: double.infinity,
              height: 150.0,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("Your Score is",textAlign: TextAlign.center,style: new TextStyle(color: Colors.white,fontSize: 15.0),),
                  new Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                    child: new Row(
                    children: <Widget>[
                        new Expanded(child: new Text("Points",textAlign: TextAlign.center,style: new TextStyle(color: Colors.white),),),
                        new Expanded(child: new Text("Matches",textAlign: TextAlign.center,style: new TextStyle(color: Colors.white),)),
                      ],
                    ),
                  ),

                  new Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child:new Text(totalScore.toString(),
                            textAlign: TextAlign.center,
                            style: new TextStyle(color: Colors.white,
                            fontSize: 30.0
                            ),
                          ),
                        ),
                        new Text("in",textAlign: TextAlign.center,style: new TextStyle(color: Colors.white),),
                        new Expanded(
                            child:new Text(totalMatches.toString(),
                            textAlign: TextAlign.center,
                            style: new TextStyle(color: Colors.white,
                            fontSize: 30.0
                          ),
                          )
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ),
        )
      );
    }
  
}