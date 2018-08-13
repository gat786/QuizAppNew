import 'package:flutter/material.dart';

class QuestionDisplay extends StatefulWidget{
  final String  question;
  final int questionNumber;

  QuestionDisplay(this.question,this.questionNumber);

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return new QuestionDisplayPage();
    }
}

 

class QuestionDisplayPage extends State<QuestionDisplay> with SingleTickerProviderStateMixin{

  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState(){
    super.initState();
    animationController=new AnimationController(vsync: this,duration: new Duration(milliseconds: 500));
    animation=new CurvedAnimation(parent: animationController,curve: Curves.linear);
    animationController.addListener(()=> this.setState(() {} ));
    animationController.forward();
  }

   @override
  void didUpdateWidget(QuestionDisplay old){
    super.didUpdateWidget(old);
    animationController.reset();
    animationController.forward();
  }


  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Material(
        color: Colors.white,
        child: new Container(
          child: new Padding(
            padding: new EdgeInsets.all(20.0),
            child: new Text("Question "+widget.questionNumber.toString()+" : "+widget.question,style: new TextStyle(color: Colors.black,fontSize: animation.value* 20.0,),textAlign: TextAlign.center,)
          )
        ),
      );
    }
}