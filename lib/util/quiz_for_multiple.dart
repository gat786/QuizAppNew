import 'package:quiz/util/question_model.dart';

class QuizMultiple {
  List<QuestionModel> _questions;
  int _currentQuestionNumber;
  int _score;
  int length;

  QuizMultiple(this._questions){
    _currentQuestionNumber=1;
    _score=0;
    _questions.shuffle();
    length=_questions.length;
  }

  
  int get score => _score;

  int get currentQuestionNumber => _currentQuestionNumber;

  QuestionModel get question => _questions[currentQuestionNumber-1];

  QuestionModel get nextQuestion{
    //print("question "+_questions[_currentQuestionNumber].question);
    _currentQuestionNumber=_currentQuestionNumber+1;
    return (isNextAvailable)?_questions[currentQuestionNumber-1]:null;
  }

  int get lengthQuestions =>_questions.length;

   bool get isNextAvailable{
    return (currentQuestionNumber<=length)?true:false; 
  }

   void answer(bool isCorrect){
    (isCorrect)?_score=_score+1:_score=_score;
  }

}