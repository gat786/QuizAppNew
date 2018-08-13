import 'package:flutter/material.dart';
import './pages/landing_page.dart';

import 'package:quiz/util/shared_preference.dart';
import 'package:quiz/util/save_audio.dart';

import 'package:quiz/web_service/authenticate.dart';


void savePreferencesIfNull() async
{
  var saveData=await getSoundPreference();
    if (saveData==null){
      saveFile();
      saveSoundPreference(true);
    }

  var saveScore=await checkScoreUploaded(0);
  if (saveScore==null){
    saveScoreUploaded(0);
  }
}
void tryFunctions(){
  loginUser("gat786", "hotMAIL123@");
}

void main(){
  savePreferencesIfNull();
  tryFunctions();
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,

    home:new LandingPage()
   
  ));
}