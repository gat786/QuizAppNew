import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:html_unescape/html_unescape.dart';

import 'package:flutter/material.dart';
import 'package:quiz/ui/option_button.dart';
import 'package:quiz/ui/question_display.dart';
import 'package:quiz/ui/correct_wrong_overlay_multiple.dart';
import 'package:quiz/util/question_model.dart';
import 'package:quiz/util/quiz_for_multiple.dart';
import 'package:quiz/util/save_audio.dart';
import 'score_page.dart';
import 'package:quiz/util/data_classes.dart';
import 'package:quiz/web_service/get_data.dart';
import 'package:quiz/web_service/parse_data.dart';

class FourQuestion extends StatefulWidget{
  final int category;
  final String cateName;

  FourQuestion(this.category,this.cateName){
    saveFile();
  }

  

  @override
  FourQuestionState createState() {
    return new FourQuestionState();
  }
}


class FourQuestionState extends State<FourQuestion> {
    bool isLoading=true;
    bool overlayVisible=false;
    List<QuestionModel> required=new List();
    QuizMultiple model;
    QuizMultipleNew modelNew;
    bool result;
    MultipleAnswer currentQuestion;
    var unescape=new HtmlUnescape();
    int questionNumber=1;
    int counter=0;

    String questionText="Hey I am Question",option1="one",option2="two",option3="three",option4="four",answer="four";


      
  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Your Progress will be lost.'),
        actions: <Widget>[
          new MaterialButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new MaterialButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Quit'),
          ),
        ],
      ),
    ) ?? false;
  }


    
    
    

    void createQuestionsListNew(List<MultipleAnswer> questions){
     modelNew = new QuizMultipleNew(questions);
     changeStateNew(modelNew);
    }


  @override
    void initState() {
      // TODO: implement initState
      super.initState();
    
      getDataApi("multiple", widget.cateName).then((var value){
        value=getParsedMultipleAnswer(value);
        List<MultipleAnswer> _questions = value;
        modelNew=new QuizMultipleNew(_questions);
        changeStateNew(modelNew);
      });
    }

    void changeStateNew(QuizMultipleNew questionModel){
      isLoading=false;
      

      currentQuestion=questionModel.question;

      questionText=unescape.convert(currentQuestion.question.toString());

      //print(currentQuestion.option);

      List options= new List();
      options.add(currentQuestion.option1);
      options.add(currentQuestion.option2);
      options.add(currentQuestion.option3);
      options.add(currentQuestion.answer);
      options.shuffle();

      option1=unescape.convert(  options[0]);

      option2=unescape.convert(  options[1]);

      option3=unescape.convert(  options[2]);

      option4=unescape.convert(  options[3]);

      answer=unescape.convert( currentQuestion.answer.toString());

      questionNumber=questionModel.currentQuestionNumber;

      this.setState((){overlayVisible=false;});
    }
    
    

    void handleAnswer(String userAnswer){
      counter=counter+1;
      result=(userAnswer==unescape.convert( currentQuestion.answer.toString()))?true:false;
      modelNew.answer(result);
      playMusic(result);
      this.setState(()
      {
        overlayVisible=true;
      });
    }


  @override
    Widget build(BuildContext context) {
      
      
      // TODO: implement build
      return new WillPopScope(
        onWillPop: _onWillPop,
        child:new Material(
            child: new Stack(
              children: <Widget>[
                    new Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                        new Expanded(
                        child: new Row(
                          children: <Widget>[
                            new Expanded(child: new OptionButton(option1,(){handleAnswer(option1);},Color.fromRGBO(0, 184, 148, 1.0)),),
                            
                            new Expanded(child:new OptionButton(option2,(){handleAnswer(option2);},Colors.orange),),
                            ],
                          ),
                      ),
                      new Container(
                        child: new QuestionDisplay(questionText, questionNumber)
                      ),
                      new Expanded(
                        child: new Row(
                          //#74b9ff
                          children: <Widget>[
                            new Expanded(child: new OptionButton(option3,(){handleAnswer(option3);},Color.fromRGBO(6, 82, 221, 1.0)),),
                            
                            new Expanded(child: new OptionButton(option4,(){handleAnswer(option4);},Color.fromRGBO(255, 118, 117, 1.0)),),
                          ],
                        ),
                      ),
                  ],
                ),
                (overlayVisible)?new CorrectWrongOverlayMultiple(result, 
                (){
                  if (counter<modelNew.lengthQuestions){
                    currentQuestion=modelNew.nextQuestion;
                    questionText=unescape.convert(currentQuestion.question.toString());

                    List options= new List();
                    options.add(currentQuestion.option1);
                    options.add(currentQuestion.option2);
                    options.add(currentQuestion.option3);
                    options.add(currentQuestion.answer);
                    options.shuffle();

                    option1=unescape.convert(  options[0]);

                    option2=unescape.convert(  options[1]);

                    option3=unescape.convert(  options[2]);

                    option4=unescape.convert(  options[3]);

                    answer=unescape.convert( currentQuestion.answer.toString());
                    answer=currentQuestion.answer;
                    questionNumber=modelNew.currentQuestionNumber;
                    this.setState((){overlayVisible=false;});
                  }
                  else{
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext build)=>new ScorePage(modelNew.score,modelNew.lengthQuestions,widget.category.toString())));
                  }
                }, unescape.convert(answer.toString())
                ):new Container(),
                (isLoading)?new Container(color: Colors.greenAccent ,
                child:new Center(
                  child: new  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    new Container(
                    child:new CircularProgressIndicator(),
                    ),
                    // new Padding(
                    //   padding: EdgeInsets.all(10.0),
                    //   child:new Text("Loading...")
                    // )
                  ],),
                  )
                  )
                :new Container()
              ],
            )
          ),       
      );
    }
}
