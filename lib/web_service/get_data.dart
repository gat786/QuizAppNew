import 'package:http/http.dart' as http;
import 'dart:async';

const String base_url="https://quizapprestapi.herokuapp.com/webapi";

Future<String> getData(String type,String subject) async {
  final response=await http.get(base_url+"/$type"+"/$subject");
  return response.body;
}


