import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:quiz/util/ensure_focus.dart';
import 'ask_name.dart';
import 'package:quiz/web_service/authenticate.dart';
import 'package:quiz/util/shared_preferences.dart';
import 'package:quiz/ui/loading_ui.dart';
import 'package:quiz/web_service/parse_data.dart';
import 'see_leaders.dart';
import 'package:quiz/ui/logged_in.dart';
import 'package:quiz/util/data_classes.dart';

List<ScoreModel> list;
bool rememberDetails=true;
bool isLoading = false;
bool gotoScore=false;
class LoginPage extends StatefulWidget {
  final FocusNode _name = new FocusNode();
  final FocusNode _password = new FocusNode();

  LoginPage(){
    isLoading=false;
    gotoScore=false;
  }
  @override
  LoginPageState createState() {
    return new LoginPageState();
  }
}

Future<int> getScore() async {
  var totalScore = 0;
  var databases = await getDatabasesPath();
  String path = join(databases, "QuizApp.db");

  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Scores (matchid INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,category TEXT, score INTEGER)");
  });

  List<Map> list = await database.rawQuery("Select * from Scores");
  for (var a in list) {
    totalScore = totalScore + a["score"];
  }

  print("score is " + totalScore.toString());
  return totalScore;
}

class LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    doesUserExist().then((bool exist) {
      if (exist) {
        getUserDetails().then((Map userDetails) {
          loginUser(userDetails["username"].toString(),
              userDetails["password"].toString()).then((String logged) {
            if (logged == "true") {
              getNamePreference().then((String userName) {
                isScoreInit().then((bool isInit) {
                  if (isInit) {
                    getScore().then((int totalScore) {
                      getUploadedScore().then((int uploadedScore) {
                        print("uploaded Score" + uploadedScore.toString());
                        int scoreToBeUploaded = totalScore - uploadedScore;
                        print("score To Be Uploaded " +
                            scoreToBeUploaded.toString());
                        getScoreFromDatabase(userName, scoreToBeUploaded)
                            .then((var data) {
                              saveScoreUploaded(totalScore);
                          this.setState(() {
                            isLoading = false;
                            list=getParsedScore(data);
                            gotoScore = true;
                          });
                        });
                      });
                    });
                  } else {
                    initScore();
                    getScore().then((int totalScore){
                      getScoreFromDatabase(userName,totalScore).then((var data){
                        list=getParsedScore(data);
                        this.setState((){
                          isLoading = false;
                          gotoScore = true;
                        });
                      });
                    });
                  }
                });
              });
            }
            else{
              this.setState((){
                isLoading=false;
              });
            }
          });
        });
      }
      else{
        this.setState((){
          isLoading=false;
        });
      }
    });
  }
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    

    var hintColor = Color.fromRGBO(199, 236, 238, 1.0);
    var labelColor = Color.fromRGBO(223, 249, 251, 1.0);

    Widget userInput = EnsureVisibleWhenFocused(
      focusNode: widget._name,
      child: new TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your username';
          }
        },
        controller: _usernameController,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: new InputDecoration(
          hintText: "Username",
          labelText: "Enter Your Username",
          hintStyle: new TextStyle(color: hintColor),
          labelStyle: new TextStyle(color: labelColor),
        ),
        focusNode: widget._name,
        onSaved: (String value) {},
      ),
    );

    Widget passInput = EnsureVisibleWhenFocused(
      focusNode: widget._password,
      child: new TextFormField(
        obscureText: true,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your email-id';
          }
        },
        controller: _passwordController,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: new InputDecoration(
          hintText: "Password",
          hintStyle: new TextStyle(color: hintColor),
          labelText: "Enter Your Password",
          labelStyle: new TextStyle(color: labelColor),
        ),
        focusNode: widget._password,
        onSaved: (String value) {},
      ),
    );

    
    Widget checkBox = new CheckboxListTile(
      title: new Text("Remember Me.",style: TextStyle(color: Colors.white),),
      value: rememberDetails,
      onChanged: ((bool value){
        this.setState(()=>rememberDetails=value);
      }),
    );

    Widget buttonSaved = new Container(
      margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
      child: new RaisedButton(
        padding: EdgeInsets.all(10.0),
        child: new Text(
          "Sign In",
          style: new TextStyle(color: Colors.white),
        ),
        color: Color.fromRGBO(255, 127, 80, 1.0),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            this.setState(()=>isLoading=true);
            loginUser(_usernameController.text, _passwordController.text).then((String result){
                    if (result=="true"){
                      if(rememberDetails==true)
                        saveUserLoginDetails(_usernameController.text, _passwordController.text);
                      getScore().then((int score){
                        getScoreFromDatabase(_usernameController.text, score).then((var data){
                          list=getParsedScore(data);
                          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new SeeLeaders(list)));
                        });
                      });
                    }else{
                      Scaffold.of(context).showSnackBar(SnackBar(content: new Text("Login Failed"),));
                    }
                  });
            
          }
        },
      ),
    );

    Widget formToFill = new Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          userInput,
          passInput,
          checkBox,
          buttonSaved,
        ],
      ),
    );

    
        return Scaffold(
            body: Stack(
            children: <Widget>[
              new Container(
                width: double.infinity,
                child: new Material(
                    color: Color.fromRGBO(236, 240, 241, 1.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                            padding: EdgeInsets.all(0.0),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Card(
                                  elevation: 10.0,
                                  child: new Container(
                                    width: 350.0,
                                    height: 355.0,
                                    color: Color.fromRGBO(26, 188, 156, 1.0),
                                    child: new Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            30.0, 30.0, 30.0, 30.0),
                                        child: formToFill),
                                  ),
                                ),
                              ],
                            )),
                        new MaterialButton(
                          child: new Text(
                            "Click here to Register",
                            style: new TextStyle(color: Colors.blueAccent),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new AskName()));
                          },
                        )
                      ],
                    )),
              ),
              (isLoading) ? IsLoading() : new Container(),
    
              (gotoScore) ? LoggedIn((){
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext build)=>new SeeLeaders(list)));
              }): new Container()
      ],
    ),
        );
  }
}
