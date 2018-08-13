import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz/ui/ask_choices_button.dart';
import 'package:quiz/util/shared_preference.dart';
import 'show_subjects.dart';

class AskChoices extends StatelessWidget{

  Future<bool> isUserRegistered() async {
    bool existence=false;
    checkUserExists().then((bool exists){existence=exists;});
    return existence;
  }

  void navigateCorrectly(String choice,BuildContext context,Color background)async{
    print("You clicked choice "+choice);

     Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=>new SubjectShow(choice)));  
    // if(choice=="mcq"){
    //   //bool registered=await isUserRegistered();
    //   //if(registered)
    //     Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=>new SubjectShow(choice)));  

    //  // Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=>new AskName(choice,background)));
    // }
    // else if(choice=="truefalse"){
    //   //bool registered=await isUserRegistered();
    //   //if(registered)
    //     Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=>new SubjectShow(choice)));  

    //  // Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=>new AskName(choice,background)));
    // }
  }


  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Material(
        child: new Column(
          children: <Widget>[
            new Expanded(child: new AskChoicesButton("MCQ",Colors.purple,()=>navigateCorrectly("mcq",context,Colors.purple)),),
            new Expanded(child: new AskChoicesButton("True Or False",Colors.blue,()=>navigateCorrectly("truefalse",context,Colors.blue)),)
          ],
        ),
      );
    }
}