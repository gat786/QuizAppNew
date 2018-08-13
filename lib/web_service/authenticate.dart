import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:quiz/util/data_classes.dart';

const String base_url="https://quizapprestapi.herokuapp.com/webapi";
const codec = const JsonCodec();

Future<String> registerUser(String username,String email,String password)async{
  var header=Map<String,String>();
  header["Content-Type"]="application/json";
  var unencoded=new UserProfile(username, email, password);
  var body=codec.encode(unencoded);
  print(body);
  final response=await http.post(base_url+"/register",headers: header,body: body);
  print(response.body);
  return response.body;
}

Future<String> loginUser(String username,String password)async{
  var header=Map<String,String>();
  header["Content-Type"]="application/json";
  var unencoded=new UserProfile.withoutEmail(username, password);
  var body=codec.encode(unencoded);
  print(body);
  final response=await http.post(base_url+"/login",headers: header,body: body);
  print(response.body);
  return response.body;
}

Future<dynamic> getScoreFromDatabase(String username,int score)async{
  var header=Map<String,String>();
  header["Content-Type"]="application/json";
  var unencoded=new ScoreModel(username, score);
  var body=codec.encode(unencoded);
  print(body);
  final response=await http.post(base_url+"/score",headers: header,body: body);
  print(response.body);
  var result=codec.decode(response.body);
  return result;
}