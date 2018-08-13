import 'package:flutter/material.dart';

class OptionsCard extends StatelessWidget{
  final IconData icon;
  final String toolText;
  final VoidCallback _onTap;

  OptionsCard(this.icon,this.toolText,this._onTap);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Padding(
                padding: EdgeInsets.all(10.0),
                child:new Container(
                  width: 350.0,
                  child: new Card(
                    child:new InkWell(
                      onTap: ()=>_onTap(),
                      child:new ListTile(
                        leading: new Icon(icon),
                        title: new Text(toolText),
                      ),
                    )
                  )
                )
              );
    }
}