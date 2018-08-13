import 'package:flutter/material.dart';
import 'package:quiz/ui/options_card.dart';
import 'personal_scores.dart';
import 'help_us.dart';

import 'settings_page.dart';
import 'login_page.dart';

class Options extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return new OptionsState();
    }
}


class OptionsState extends State<Options>{
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        body: new Material(
          color: Colors.yellow[100],
          child: new Container(
            width: double.infinity,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                new OptionsCard(Icons.settings,"Settings",
                (){
                  print("You tapped Settings ");
                  Navigator.of(context).push(new MaterialPageRoute(builder:(BuildContext context)=>new SettingsPage(),
                  ));
                  }
                ),

                new OptionsCard(Icons.people,"Personal Scores",
                  (){
                      print("You tapped Personal Scores ");
                      //showDialog(context: context,child: new PersonalScore());
                      Navigator.of(context).push(new MaterialPageRoute(builder:(BuildContext context)=>new PersonalScore()));
                  }
                ),

                new OptionsCard(Icons.accessibility,"Leaderboards",
                  (){ 
                      print("You tapped Leaderboards ");
                      Navigator.of(context).push(new MaterialPageRoute(builder:(BuildContext context)=>new LoginPage()));
                  }
                ),

                new OptionsCard(Icons.help, "Suggest a Question ", 
                (){
                    print("You clicked to help us");
                    Navigator.of(context).push(new MaterialPageRoute(builder:(BuildContext context)=>new HelpUs()));
                }
                )

              ],
            ),
          ),
        ),
      );
    }
}