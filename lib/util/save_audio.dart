import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayer/audioplayer.dart';
import 'shared_preference.dart';


Future<ByteData> loadAsset1() async {
    return await rootBundle.load('sounds/failure.mp3');
}

Future<ByteData> loadAsset2() async {
    return await rootBundle.load('sounds/success.mp3');
}

File file,file1;

void saveFile() async {
  file = new File('${(await getApplicationDocumentsDirectory()).path}/failure.mp3');
  await file.writeAsBytes((await loadAsset1()).buffer.asUint8List());

  file1 = new File('${(await getApplicationDocumentsDirectory()).path}/success.mp3');
  await file1.writeAsBytes((await loadAsset2()).buffer.asUint8List());
  audioPreference=await getSoundPreference();
  print("File saved");
  print("Preference is "+audioPreference.toString());
}

bool audioPreference;

var audioPlayer=new AudioPlayer();

void playFailureMusic() async {  
  await audioPlayer.play(file.path, isLocal: true);
}

void playSuccessMusic() async {
  await audioPlayer.play(file1.path, isLocal: true);
}

 void playMusic(bool result) async {
   if(audioPreference){
    if (result)
    playSuccessMusic();
    else
    playFailureMusic();
  }
 }