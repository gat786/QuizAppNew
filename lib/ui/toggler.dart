import 'package:flutter/material.dart';

class Toggler extends StatefulWidget{
  final VoidCallback _onTapTrue;
  final VoidCallback _onTapFalse;

  Toggler(this._onTapTrue,this._onTapFalse);

  @override
    State<StatefulWidget> createState() {
      return TogglerState();
    }
}

class TogglerState extends State<Toggler>{
  @override
    Widget build(BuildContext context) {
      var styleText=new TextStyle(color: Colors.white,fontSize: 16.0);
      // TODO: implement build
      return new Container(
        padding: EdgeInsetsDirectional.only(top: 10.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              color: Colors.green,
              child: new Container(
                child: new Text("True",style: styleText,)
              ),
              onPressed: widget._onTapTrue,
            ),
            
            new RaisedButton(
              color: Colors.red,
              child: new Text("False",style: styleText,),
              onPressed: widget._onTapFalse,
            )
          ],
        ),
      );
    }
}