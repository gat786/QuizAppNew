import 'package:flutter/material.dart';
class ScoreLeaders extends StatelessWidget{
  final textStyle=new TextStyle(color: Colors.white);
  final textStylePlayers=new TextStyle(color: Colors.black);
  Widget returnScoreList(String srNo,String userName,String score,Color givenColor,TextStyle givenTextStyle){
    var returnable=Container(
      child: new Row(

        children: <Widget>[

          Expanded(child: new Text(srNo,style: givenTextStyle,),flex: 1,),

          Expanded(child: new Text(userName,style: givenTextStyle,),flex: 3,),


          Expanded(child: new Text(score,style: givenTextStyle,),flex: 1,)
        ],

      ),
      color: givenColor,
      height: 30.0,
      padding: EdgeInsets.only(left: 10.0),
    );
    return returnable;
  }

  @override
  Widget build(BuildContext context) {


    var scoresList=returnScoreList("1","ganesh","320",Colors.white,textStylePlayers);

    // TODO: implement build
    return new Material(
      child:new Container(
        child:  Container(
          height: 360.0,
          child: new ListView(
            children: <Widget>[
              returnScoreList("Sr No", "User Name", "Score",Colors.blueAccent,textStyle),

              scoresList,

              scoresList,

              scoresList,

              scoresList,

              scoresList,

              scoresList,

              scoresList,

              scoresList,

              scoresList,

              scoresList,
            ]
        )
      )
    )
    );
  }
}