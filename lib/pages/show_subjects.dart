
import 'package:flutter/material.dart';
import 'package:quiz/ui/subject_button.dart';
import 'four_option_question.dart';
import 'quiz_page.dart';


class SubjectShow extends StatelessWidget{

  final String questionsType;

  SubjectShow(this.questionsType);



  void gotoFourQuestion(int category,BuildContext context){
        if (questionsType=="mcq")
          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext build) => new FourQuestion(category)));
        else 
          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext build) => new Quizpage(category.toString())));
      }



  
  @override
    Widget build(BuildContext context) {
      
      // TODO: implement build
      return new Material(
        color: Colors.white,
        child: new ListView(
          
          children: <Widget>[
            new SubjectButton(Colors.redAccent, "Science",() { gotoFourQuestion(17,context); }),

            new SubjectButton(Colors.pinkAccent, "History",(){ gotoFourQuestion(23, context); }),

            new SubjectButton(Colors.orangeAccent, "Geography",(){ gotoFourQuestion(22, context); }),
            
            new SubjectButton(Color.fromRGBO(87, 96, 111, 1.0), "Computer Science",(){ gotoFourQuestion(18, context);}),

            new SubjectButton(Color.fromRGBO(95, 39, 205, 1.0), "Films",(){ gotoFourQuestion(11, context);}),

            new SubjectButton(Color.fromRGBO(33, 140, 116, 1.0), "Mythology",(){ gotoFourQuestion(20, context);}),

            new SubjectButton(Color.fromRGBO(18, 137, 167, 1.0), "Sports",(){ gotoFourQuestion(21, context);}),
          ],
        ),
      );
    }
}