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

class FourQuestion extends StatefulWidget{
  final int category;

  FourQuestion(this.category){
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
    bool result;
    QuestionModel currentQuestion;
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




    Map<String,dynamic> data;
    Future<String> getData(String url) async {
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
        }
      );
      data = json.decode(response.body);
      print(data);
      createQuestionsList(data["results"]);
      
      return "Success!";
    }
    
    
    
    void createQuestionsList(List<dynamic> dataList){
      print(dataList.length);
      for (var a in dataList){
        print(a["question"]);
        String question=a["question"].toString();
        List options=a["incorrect_answers"];
        options.add(a["correct_answer"]);
        options.shuffle();
        String answer=a["correct_answer"].toString();
        QuestionModel model=new QuestionModel(question, answer, options);
        required.add(model);
        }
      model=new QuizMultiple(required);
      changeState();
    }


  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      
      String first="https://opentdb.com/api.php?amount=10&category=";
      String second="&difficulty=easy&type=multiple";
      getData(first+widget.category.toString()+second);
    }
    
    void changeState(){
      isLoading=false;
      

      currentQuestion=model.question;

      questionText=unescape.convert(currentQuestion.question.toString());

      //print(currentQuestion.option);

      option1=unescape.convert(  currentQuestion.option[0].toString());

      option2=unescape.convert( currentQuestion.option[1].toString());

      option3=unescape.convert(  currentQuestion.option[2].toString());

      option4=unescape.convert(  currentQuestion.option[3].toString());

      answer=unescape.convert( currentQuestion.answer.toString());

      questionNumber=model.currentQuestionNumber;

      this.setState((){overlayVisible=false;});
    }

    void handleAnswer(String userAnswer){
      counter=counter+1;
      result=(userAnswer==unescape.convert( currentQuestion.answer.toString()))?true:false;
      model.answer(result);
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
                  if (counter<model.lengthQuestions){
                    currentQuestion=model.nextQuestion;
                    questionText=unescape.convert(currentQuestion.question.toString());

                    option1=unescape.convert(  currentQuestion.option[0].toString());

                    option2=unescape.convert( currentQuestion.option[1].toString());

                    option3=unescape.convert(  currentQuestion.option[2].toString());

                    option4=unescape.convert(  currentQuestion.option[3].toString());

                    answer=unescape.convert( currentQuestion.answer.toString());
                    answer=currentQuestion.answer;
                    questionNumber=model.currentQuestionNumber;
                    this.setState((){overlayVisible=false;});
                  }
                  else{
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext build)=>new ScorePage(model.score,model.lengthQuestions,widget.category.toString())));
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
