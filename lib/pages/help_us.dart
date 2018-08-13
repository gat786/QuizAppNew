import 'package:flutter/material.dart';
import 'package:quiz/ui/ask_choices_button.dart';
import 'help_us_multiple.dart';
import 'help_us_boolean.dart';

class HelpUs extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(

      body: Material(
        child: new Column(
          children: <Widget>[
            new Expanded(
                child: new InkWell(
                    child: new AskChoicesButton("MCQ", Colors.red, (){
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new HelpUsMultiple()));
                    }
                    )
                ),
              flex: 5,
            ),
            new Expanded(
                child: new AskChoicesButton("True or False", Colors.blue, (){
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new HelpUsBoolean()));
                }),
                flex: 5,

            ),
            
            new Expanded(
                child: new Container(
                  color: Colors.grey,
                  child: new Center(
                  child:  new Text("Select Type Of Question You want To Submit",
                      style: new TextStyle( fontSize: 16.0,color: Colors.white),
                    ),
                  ),
                )
            )

          ],
        ),
      ),
    );
  }
}