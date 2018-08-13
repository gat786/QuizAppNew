import 'package:flutter/material.dart';

class SubjectButton extends StatelessWidget{
  final String  text;
  final Color colorName;
  final VoidCallback onTap;

  SubjectButton(this.colorName,this.text,this.onTap);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Material(
        color: Colors.transparent,
        child: new Card(
          color: colorName,
          margin: new EdgeInsets.all(10.0),
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.all(new Radius.circular(8.0),),),
          child: new InkWell(
            onTap: ()=>onTap(),
            child:new Container(
              height: 150.0,
              child:new Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                new Container(height: 200.0),
                
                new Center(child:new Text(text,style: new TextStyle(color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.bold,),)),

              ],
            ),
            )
          )
        ),
      );
    }
}