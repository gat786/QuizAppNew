import 'package:flutter/material.dart';
import './ask_choices.dart';
import 'options.dart';

class LandingPage extends StatelessWidget{

  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        body:new Container(
          width: double.infinity,
          child: new Material(
            color: Colors.red,
              child: new InkWell(
              child: new Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("Lets Start",style: new TextStyle(fontSize: 50.0,fontWeight: FontWeight.bold,color: Colors.white),), 
                  new Text("Tap To Start",style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white),),
                  // new IconButton(icon: new Icon(Icons.more,color: Colors.white,size: 40.0,),
                  // onPressed: 
                  // ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext build)=>new SubjectShow())), 
                  // ),
                  // new Padding
                    // (
                      // padding: EdgeInsets.all(10.0),
                      // child:new Text("Click Here Select Subjects",style: new TextStyle(fontSize: 10.0,fontWeight: FontWeight.bold,color: Colors.white)
                    // ),
                  // ),
                  // new IconButton(icon: new Icon(Icons.timeline,color: Colors.white,size: 40.0,),
                  // onPressed: 
                  // ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext build)=>new LeaderBoard())), 
                  // ),
                  // new Padding
                    // (
                      // padding: EdgeInsets.all(10.0),
                      // child:new Text("Click Here For LeaderBoards",style: new TextStyle(fontSize: 10.0,fontWeight: FontWeight.bold,color: Colors.white)
                    // ),
                  // )
                ],
              ),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext build)=>new AskChoices())),
            ),
          ),
        ),
        floatingActionButton: new FloatingActionButton(
            elevation: 8.0,
            notchMargin: 4.0,
            highlightElevation: 10.0,
            shape: const CircleBorder(),
            backgroundColor: Colors.yellow[200],
            child: new Icon(Icons.star),
            foregroundColor: Colors.red,
            onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext build)=>new Options()));
            },
          )
      );
    }
}