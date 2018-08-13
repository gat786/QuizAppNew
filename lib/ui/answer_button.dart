import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget{

  final bool _answer;
  final VoidCallback _onTap;

  AnswerButton(this._answer,this._onTap);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Material(
        color: (_answer)?Colors.green:Colors.red,
        child: new InkWell(
          onTap: () => _onTap(),
          child: new Center(
            child: new Container(
              decoration: new BoxDecoration(
                border: new Border.all(color: Colors.white,width: 5.0)
              ),
              child: new Padding(
                padding: EdgeInsets.all(20.0),
                child : new Text((_answer)?"True":"False",style:new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white)),
              )
            )
          ),
        ),
      );
    }
}