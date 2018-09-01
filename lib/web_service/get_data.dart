import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const String base_url="https://quizapprestapi.herokuapp.com/webapi";

Future<dynamic> getDataApi(String type,String subject) async {
  final response=await http.get(base_url+"/$type"+"/$subject");
  var data = json.decode(response.body);
  return data;
}


