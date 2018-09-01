import 'package:flutter/material.dart';
import 'package:quiz/util/data_classes.dart';

class SeeLeaders extends StatefulWidget {
  final score = 20;
  final List<ScoreModel> data;
  SeeLeaders(this.data);
  @override
  SeeLeadersState createState() {
    return new SeeLeadersState(data);
  }
}

class SeeLeadersState extends State<SeeLeaders> {
  final textStyle = new TextStyle(color: Colors.white);
  final textStylePlayers = new TextStyle(color: Colors.black);

  Widget returnScoreList(String srNo, String userName, String score,
      Color givenColor, TextStyle givenTextStyle) {
    var returnable = Container(
      child: new Row(
        children: <Widget>[
          Expanded(
            child: new Text(
              srNo,
              style: givenTextStyle,
            ),
            flex: 1,
          ),
          Expanded(
            child: new Text(
              userName,
              style: givenTextStyle,
            ),
            flex: 3,
          ),
          Expanded(
            child: new Text(
              score,
              style: givenTextStyle,
            ),
            flex: 1,
          )
        ],
      ),
      color: givenColor,
      height: 30.0,
      padding: EdgeInsets.only(left: 10.0),
    );
    return returnable;
  }

  var scoresList;
  var score1,
      score2,
      score3,
      score4,
      score5,
      score6,
      score7,
      score8,
      score9,
      score10;

  List<Widget> score = new List();
  SeeLeadersState(List<ScoreModel> data) {
    scoresList =
        returnScoreList("1", "ganesh", "320", Colors.white, textStylePlayers);

    for (int i = 0; i < 10; i = i + 1) {
      score.add(returnScoreList((i+1).toString(), data[i].username,
          data[i].score.toString(), Colors.white, textStylePlayers));
    }

    // score1 =
    //     returnScoreList("1",  data[0].username, data[0].score.toString(), Colors.white, textStylePlayers);
    // score2 =
    //     returnScoreList("2",  data[1].username, data[1].score.toString(), Colors.white, textStylePlayers);
    // score3 =
    //     returnScoreList("3",  data[2].username, data[2].score.toString(), Colors.white, textStylePlayers);
    // score4 =
    //     returnScoreList("4",  data[3].username, data[3].score.toString(), Colors.white, textStylePlayers);
    // score5 =
    //     returnScoreList("5",  data[4].username, data[4].score.toString(), Colors.white, textStylePlayers);
    // score6 =
    //     returnScoreList("6",  data[5].username, data[5].score.toString(), Colors.white, textStylePlayers);
    // score7 =
    //     returnScoreList("7",  data[6].username, data[6].score.toString(), Colors.white, textStylePlayers);
    // score8 =
    //     returnScoreList("8",  data[7].username, data[7].score.toString(), Colors.white, textStylePlayers);
    // score9 =
    //     returnScoreList("9",  data[8].username, data[8].score.toString(), Colors.white, textStylePlayers);
    // score10 =
    //     returnScoreList("10",  data[9].username, data[9].score.toString(), Colors.white, textStylePlayers);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: new Icon(Icons.close),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: new Material(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              
              child: new Material(
                color: Colors.white,
                  child: new Container(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(right: 10.0,left: 10.0),
                            height: 360.0,
                            child: new ListView(children: <Widget>[
                              returnScoreList("Sr No", "User Name", "Score",
                                  Colors.blueAccent, textStyle),
                              score[0],
                              score[1],
                              score[2],
                              score[3],
                              score[4],
                              score[5],
                              score[6],
                              score[7],
                              score[8],
                              score[9]
                            ])),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
