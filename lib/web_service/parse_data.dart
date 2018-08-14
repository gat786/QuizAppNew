import 'package:quiz/util/data_classes.dart';

List<ScoreModel> getParsedScore(var data){
  List<ScoreModel> tobeReturned=new List();
  ScoreModel model;
  for (var a in data){
    model=new ScoreModel(a["userName"],a["score"]);
    tobeReturned.add(model);
  }
  return tobeReturned;
}

List<SingleAnswer> getParsedSingleAnswer(var data){
  List<SingleAnswer> tobeReturned=new List();
  SingleAnswer answer;
  for(var a in data){
    answer=new SingleAnswer.withoutSubject(a["answer"], a["question"]);
    tobeReturned.add(answer);
  }
  return tobeReturned;
}

List<MultipleAnswer> getParsedMultipleAnswer(var data){
  List<MultipleAnswer> tobeReturned=new List();
  MultipleAnswer answer;
  for(var a in data){
    answer=MultipleAnswer.withoutSubject(a["answer"], a["question"], a["option1"], a["option2"], a["option3"]);
    tobeReturned.add(answer);
  }
  return tobeReturned;
}