import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz/util/quiz.dart';
import 'package:quiz/ui/answer_button.dart';
import 'package:quiz/ui/question_display.dart';
import 'package:quiz/ui/correct_wrong_overlay.dart';
import 'score_page.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quiz/util/save_audio.dart';
import 'package:quiz/util/data_classes.dart';
import 'package:quiz/web_service/parse_data.dart';
import 'package:quiz/web_service/get_data.dart';

var dataRecieved;

String dataUrl;
class Quizpage extends StatefulWidget{
  final String category;
  final String cateName;
  
  Quizpage(this.category,this.cateName){
    saveFile();
  }

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return new QuizPageState();
    }
}

class QuizPageState extends State<Quizpage>{
    bool isLoading=true;
    bool displayOverlay=false;
    bool result;
    SingleAnswer singleAnswerQuestion;
    int questionNumber=1;
    int counter=0;
    var unescape=new HtmlUnescape();


  //  Map<String,dynamic> data;
  //   Future<String> getData(String url) async {
  //   var response = await http.get(
  //     Uri.encodeFull(url),
  //     headers: {
  //       "Accept": "application/json"
  //       }
  //     );
  //     data = json.decode(response.body);
  //     print(data);
  //     createQuestionsList(data["results"]);
      
  //     return "Success!";
  //   }

    // createQuestionsList(List<dynamic> results){
    //   List<Question> listQuestions=new List();
    //   for (var a in results){
    //     String _question= unescape.convert(  a["question"]);
    //     bool _answer=(unescape.convert( a["correct_answer"])=="True")?true:false;
    //     Question question=new Question(_question,_answer);
    //     listQuestions.add(question);
    //   }
    //   quiz=new Quiz(listQuestions);
    //   changeState();
    // }

    
    QuizNew quizNew;
    void changeStateNew(){
      isLoading=false;
      quizNew = new QuizNew(dataRecieved);
      singleAnswerQuestion=quizNew.question;
      questionText=singleAnswerQuestion.question;
      questionNumber=quizNew.currentQuestionNumber;
      this.setState((){ displayOverlay=false; });
    }

    // void changeState(){
    //   print("changing State");
    //   isLoading=false;
    //   currentQuestion=quiz.question;
    //   questionText=currentQuestion.question;
    //   questionNumber=quiz.currentQuestionNumber;
    //   this.setState((){ displayOverlay=false; });
    // }



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



String questionText;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataApi("boolean", widget.cateName).then((var data){
       dataRecieved = getParsedSingleAnswer(data);
       changeStateNew();
    });
  }
  
 

  void handleAnswer(bool userAnswer){
    counter=counter+1;
    bool corrAnswer;
    (singleAnswerQuestion.answer=="True")?corrAnswer=true:corrAnswer=false;
    if (userAnswer==corrAnswer){
      result=true;
    }
    else{
      result=false;
    }
    quizNew.answer(result);
    this.setState((){
      displayOverlay=true;
      playMusic(result);
    });
  }

    @override
      Widget build(BuildContext context) {
        
        // TODO: implement build
        return new WillPopScope(
          onWillPop: _onWillPop,
          child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Column(              
              children: <Widget>[
                new Expanded(child: new AnswerButton(true,(){ handleAnswer(true); } ),),
                new Row(children: <Widget>[
                  new Expanded(child:new QuestionDisplay(questionText,questionNumber)),
                ],),
                new Expanded(child: new AnswerButton(false,(){ handleAnswer(false); } ),)
              ],
            ),
          (displayOverlay)?new CorrectWrongOverlay(result,(){
            if (counter<quizNew.lengthQuestions){
            singleAnswerQuestion=quizNew.nextQuestion;
            questionText=singleAnswerQuestion.question;
            questionNumber=quizNew.currentQuestionNumber;
            print("current "+singleAnswerQuestion.question);
          this.setState((){
            displayOverlay=false;
          });
            }
            else{
              Navigator.of(context).pushReplacement(new MaterialPageRoute(builder:( BuildContext context)=>new ScorePage(quizNew.score, quizNew.lengthQuestions,widget.category)));
            }
          }):new Container(),  

        (isLoading)?new Container(color: Colors.greenAccent ,
            child:new Center(
              child: new  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                child:new CircularProgressIndicator(),
                ),
              ],),
              )
              )
            :new Container()

          ],
        ),
        );
      }
}