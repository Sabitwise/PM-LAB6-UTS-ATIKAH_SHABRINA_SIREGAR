import 'package:flutter/material.dart';
import '../data/question_data.dart';
import '../model/question.dart';

class QuizProvider extends ChangeNotifier{
  int _currentIndex = 0;
  int _score = 0;
  List <int?> _selectedAnswers = List.filled(questionList.length, null);

  int get currentIndex => _currentIndex;
  int get score => _score;
  Question get currentQuestion => questionList[_currentIndex];
  List<int?> get selectedAnswers => _selectedAnswers;

  void selectAnswer(int index){
    _selectedAnswers[_currentIndex] = index;
    notifyListeners();
  }

  void nextQuestion(){
    if (_currentIndex < questionList.length - 1){
      _currentIndex++;
      notifyListeners();
    }
  }
  void calculateScore(){
    _score = 0;
    for (int i = 0; i < questionList.length; i++){
      if(_selectedAnswers[i] == questionList[i].correctIndex){
        _score++;
      }
    }
  }

  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void resetQuiz(){
    _currentIndex = 0;
    _score = 0;
    _selectedAnswers = List.filled(questionList.length, null);
    notifyListeners();
  }
}