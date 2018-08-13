import 'dart:convert';
import 'package:http/http.dart' as http;


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz/util/quiz.dart';
import 'package:quiz/ui/answer_button.dart';
import 'package:quiz/util/question.dart';
import 'package:quiz/ui/question_display.dart';
import 'package:quiz/ui/correct_wrong_overlay.dart';
import 'score_page.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quiz/util/save_audio.dart';

String urlStart="https://opentdb.com/api.php?amount=10&category=";
String urlEnd="&type=boolean";



// Future<ByteData> loadAsset1() async {
//     return await rootBundle.load('sounds/failure.mp3');
// }

// Future<ByteData> loadAsset2() async {
//     return await rootBundle.load('sounds/success.mp3');
// }

// File file,file1;

// void saveFile()async {
//   file = new File('${(await getApplicationDocumentsDirectory()).path}/failure.mp3');
//   await file.writeAsBytes((await loadAsset1()).buffer.asUint8List());

//   file1 = new File('${(await getApplicationDocumentsDirectory()).path}/success.mp3');
//   await file1.writeAsBytes((await loadAsset2()).buffer.asUint8List());
//   print("File saved");
// }



String dataUrl;
class Quizpage extends StatefulWidget{
  final String category;
  
  Quizpage(this.category){
    dataUrl=urlStart+category+urlEnd;
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
    Question currentQuestion;
    int questionNumber=1;
    int counter=0;
    var unescape=new HtmlUnescape();


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

    createQuestionsList(List<dynamic> results){
      List<Question> listQuestions=new List();
      for (var a in results){
        String _question= unescape.convert(  a["question"]);
        bool _answer=(unescape.convert( a["correct_answer"])=="True")?true:false;
        Question question=new Question(_question,_answer);
        listQuestions.add(question);
      }
      quiz=new Quiz(listQuestions);
      changeState();
    }



    void changeState(){
      print("changing State");
      isLoading=false;
      currentQuestion=quiz.question;
      questionText=currentQuestion.question;
      questionNumber=quiz.currentQuestionNumber;
      this.setState((){ displayOverlay=false; });
    }



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

    Quiz quiz=new Quiz([
      new Question("Pizza is Healthy", false),
      new Question("Is Waking Up A Good Habit", true),
      new Question("India Is Great", true),
      new Question("Is Google a Social Network", false),
      new Question("Capital of India is Mumbai", false),
      new Question("Flutter is Awesome", true ),
      new Question("Android Apps are Great ", true),
      new Question("Earth is a Star", false),
      new Question("Sun is a Planet ", false),
      new Question("Nasa is a Space Organization ", true),
    ]);


String questionText;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    currentQuestion=quiz.question;
    questionText=currentQuestion.question;
    questionNumber=quiz.currentQuestionNumber;

    getData(dataUrl);
  }

 

  void handleAnswer(bool userAnswer){
    counter=counter+1;
    if (userAnswer==currentQuestion.answer){
      result=true;
    }
    else{
      result=false;
    }
    quiz.answer(result);
    this.setState((){
      displayOverlay=true;
      playMusic(result);
    });
  }

    @override
      Widget build(BuildContext context) {
        print("Updating UI "+questionText+questionNumber.toString());
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
            if (counter<quiz.lengthQuestions){
            currentQuestion=quiz.nextQuestion;
            questionText=currentQuestion.question;
            questionNumber=quiz.currentQuestionNumber;
            print("current "+currentQuestion.question);
          this.setState((){
            displayOverlay=false;
          });
            }
            else{
              Navigator.of(context).pushReplacement(new MaterialPageRoute(builder:( BuildContext context)=>new ScorePage(quiz.score, quiz.lengthQuestions,widget.category)));
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