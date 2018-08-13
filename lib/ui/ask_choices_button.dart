import 'package:flutter/material.dart';

class AskChoicesButton extends StatelessWidget{
  final String textWord;
  final Color inkColor;
  final VoidCallback _onTap;
  AskChoicesButton(this.textWord,this.inkColor,this._onTap);
 @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Material(
        color:inkColor,
        child: new InkWell(
          onTap:_onTap,
          child: new Center(
            child: new Container(
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: new Border.all(color: Colors.white,width: 5.0)
              ),
              child: new Padding(
                padding: EdgeInsets.all(20.0),
                child : new Text(textWord,style:new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white)),
              )
            )
          ),
        ),
      );
    }
}