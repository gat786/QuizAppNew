
import 'package:flutter/material.dart';
import 'package:quiz/util/ensure_focus.dart';

class HelpUsMultiple extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HelpUsMultipleState();
  }

  
}


FocusNode _question=new FocusNode();
FocusNode _answer=new FocusNode();
FocusNode _option1=new FocusNode();
FocusNode _option2=new FocusNode();
FocusNode _option3=new FocusNode();
var selectedValue=null;
String subSelected="";
class HelpUsMultipleState extends State<HelpUsMultiple> {
  final _formKey = GlobalKey<FormState>();
  
  HelpUsMultipleState(){
    subSelected="";
  }

  var typeDrop=new List<DropdownMenuItem<String>>();
  void createTypeDrop(){
    typeDrop=[];
    typeDrop.add(new DropdownMenuItem(child: new Text("Science"),value: "science",));
    typeDrop.add(new DropdownMenuItem(child: new Text("History"),value: "history",));
    typeDrop.add(new DropdownMenuItem(child: new Text("Geography"),value: "geography",));
    typeDrop.add(new DropdownMenuItem(child: new Text("Sports"),value: "sports",));
    typeDrop.add(new DropdownMenuItem(child: new Text("Computer Science"),value: "computers",));
    typeDrop.add(new DropdownMenuItem(child: new Text("Mythology"),value: "myth",));
    typeDrop.add(new DropdownMenuItem(child: new Text("Films"),value: "films",));
  }

  String selectedType;
  bool isMultiple=false;
  @override
  Widget build(BuildContext context) {
    createTypeDrop();
    var selector= new DropdownButton<String>(
      items: typeDrop,
      hint: new Text("Please Select a Subject"),
      onChanged: (String value) {
      print("You selected $value");
      selectedType=value;
      subSelected=value;
      this.setState((){});
    },
      value: selectedType,
    );
    // TODO: implement build
    return new Scaffold(

        body:Form(
            key: _formKey,
            child: new ListView(
            children: <Widget>[

              new Container(
                child: new Center(child: selector,),
                height: 70.0,
                color: Colors.greenAccent,
              ),

              new Padding(padding: EdgeInsets.only(left: 20.0,right: 20.0),
                child: new EnsureVisibleWhenFocused(
                  focusNode: _question,
                  child: new TextFormField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: new InputDecoration(
                      hintText: "Question",
                      hintStyle: new TextStyle(color: Colors.black38),
                      labelText: "Question",
                      labelStyle: new TextStyle(color: Colors.black),
                    ),
                    focusNode: _question,
                    onSaved: (String value){

                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter question';
                      }
                    },
                  ),
                ),
              ),

              new Padding(
                padding: EdgeInsets.only(left: 20.0,right: 20.0),
                child: new EnsureVisibleWhenFocused(
                  focusNode: _answer,
                  child: new TextFormField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: new InputDecoration(
                      hintText: "Answer",
                      hintStyle: new TextStyle(color: Colors.black38),
                      labelText: "Answer",
                      labelStyle: new TextStyle(color: Colors.black),
                    ),
                    focusNode: _answer,
                    onSaved: (String value){

                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter answer';
                      }
                    },
                  ),
                ),
              ),


              new Padding(
                padding: EdgeInsets.only(left: 20.0,right: 20.0),
                child: new EnsureVisibleWhenFocused(
                focusNode: _option1,
                child: new TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(
                    hintText: "First Option",
                    hintStyle: new TextStyle(color: Colors.black38),
                    labelText: "First Option",
                    labelStyle: new TextStyle(color: Colors.black),
                  ),
                  focusNode: _option1,
                  onSaved: (String value){

                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter option 1 ';
                    }
                  },
                  
                ),
              ),
              ),


              new Padding(
                padding: EdgeInsets.only(left: 20.0,right: 20.0),
                child: new EnsureVisibleWhenFocused(
                focusNode: _option2,
                child: new TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(
                    hintText: "Second Option",
                    hintStyle: new TextStyle(color: Colors.black38),
                    labelText: "Second Option",
                    labelStyle: new TextStyle(color: Colors.black),
                  ),
                  focusNode: _option2,
                  onSaved: (String value){

                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter option 2 ';
                    }
                  },
                ),
              ),),

              new Padding(
                padding: EdgeInsets.only(left: 20.0,right: 20.0),
                child: new EnsureVisibleWhenFocused(
                focusNode: _option3,
                child: new TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(
                    hintText: "Third Option",
                    hintStyle: new TextStyle(color: Colors.black38),
                    labelText: "Third Option",
                    labelStyle: new TextStyle(color: Colors.black),
                  ),
                  focusNode: _option3,
                  onSaved: (String value){

                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter option 3 ';
                    }
                  },
                ),
              ),),

              Builder(
                  builder:(BuildContext context){
                  return new Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                    child: new MaterialButton(
                      color: Colors.blueAccent,
                      child: new Text("Submit Question....",style: new TextStyle(color:Colors.white),),
                      onPressed: (){
                        print("You pressed Submit..");
                        if (_formKey.currentState.validate()){
                          print(subSelected);
                          if (subSelected==""){
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please Select a Subject"),));
                          }
                          else  {
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Successfull"),));
                          }
                        }
                      },
                    )
                  );
                }
              )
            ],
          ),
        )

    );
  }
}

