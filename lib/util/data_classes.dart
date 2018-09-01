class SingleAnswer{
  
  String answer,question,subject;

  SingleAnswer(this.answer,this.question,this.subject);

  SingleAnswer.withoutSubject(this.answer,this.question);

  Map<String, dynamic> toJson() =>
    {
      'answer': answer,
      'question': question,
      'subject': subject
    };

}

class MultipleAnswer{
  
  String answer,question,option1,option2,option3,subject;

  MultipleAnswer(this.answer,this.question,this.option1,this.option2,this.option3,this.subject);

  MultipleAnswer.withoutSubject(this.answer,this.question,this.option1,this.option2,this.option3);

  Map<String, dynamic> toJson() =>
    {
      'answer': answer,
      'question': question,
      'option1':option1,
      'option2':option2,
      'option3':option3,
      'subject': subject
    };

}

class UserProfile{
  String username,email,password;

  UserProfile(this.username,this.email,this.password);

  UserProfile.withoutEmail(this.username,this.password);

   Map<String, dynamic> toJson() =>
    {
      'username': username,
      'email': email,
      'password':password
    };
}

class ScoreModel{
  String username;
  int score;

  ScoreModel(this.username,this.score);

   Map<String, dynamic> toJson() =>
    {
      'username': username,
      'score': score,
    };
}


class Category{
  Map<int,String> _data=new Map<int,String>();

  Category(){
    _data[17]="science";
    _data[22]="geography";
    _data[23]="history";
    _data[20]="mythology";
    _data[11]="films";
    _data[21]="sports";
    _data[18]="computers";
  }

  String getCategoryName(int categoryNumber){
    return _data[categoryNumber];
  }
}