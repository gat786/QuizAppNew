import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:quiz/util/data_classes.dart';

const String base_url="https://quizapprestapi.herokuapp.com/webapi";
const codec = const JsonCodec();

Future<String> putDataMultiple(String question,String answer,String option1,String option2,String option3,String subject) async {
  var header=Map<String,String>();
  header["Content-Type"]="application/json";
  var questionNE=new MultipleAnswer(answer, question, option1, option2, option3, subject);
  var body=codec.encode(questionNE);
  print(body);
  final response=await http.post(base_url+"/multiple",headers: header,body: body);
  print(response.body);
  return response.body;
}

Future<String> putDataBoolean(String question,String answer,String subject) async {
  var header=Map<String,String>();
  header["Content-Type"]="application/json";
  var questionNE=new SingleAnswer(answer, question, subject);
  var body=codec.encode(questionNE);
  print(body);
  final response=await http.post(base_url+"/boolean",headers: header,body: body);
  print(response.body);
  return response.body;
}