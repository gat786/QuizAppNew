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