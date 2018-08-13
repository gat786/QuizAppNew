import 'package:flutter/material.dart';

class LoggedIn extends StatelessWidget {
  final VoidCallback _onTap;
  LoggedIn(this._onTap);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Material(
      color: Colors.blue,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("You are Already Logged in.!",style: new TextStyle(color: Colors.white,fontSize: 20.0),),
              new FlatButton(child: new Text("See Scores"), onPressed: _onTap)
            ],
          ),
        
      ),
    );
  }
}
