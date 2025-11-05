import 'package:flutter/material.dart';
import '../data/question_data.dart';
import '../model/question.dart';

class QuizProvider extends ChangeNotifier {
  String name = '';
  String studentClass = '';
  bool hasCompletedQuiz = false;

  int _currentIndex = 0;
  List<int?> _selectedAnswers = List.filled(questionList.length, null);

  int get currentIndex => _currentIndex;
  Question get currentQuestion => questionList[_currentIndex];
  List<int?> get selectedAnswers => _selectedAnswers;
  int get totalQuestions => questionList.length;

  int get score => correct;


  int get correct {
    int c = 0;
    for (int i = 0; i < questionList.length; i++) {
      final sel = _selectedAnswers[i];
      if (sel != null && sel == questionList[i].correctIndex) {
        c++;
      }
    }
    return c;
  }


  int get answered {
    return _selectedAnswers.where((s) => s != null).length;
  }


  int get wrong => answered - correct;

  int get completion {
    if (totalQuestions == 0) return 0;
    return ((answered / totalQuestions) * 100).toInt();
  }


  void setPlayerInfo(String newName, String newClass) {
    name = newName;
    studentClass = newClass;
    notifyListeners();
  }

  void selectAnswer(int index) {
    _selectedAnswers[_currentIndex] = index;
    notifyListeners(); // UI akan ambil getters terbaru (correct/wrong/completion)
  }


  void nextQuestion() {
    if (_currentIndex < questionList.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }


  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }


  void calculateScore() {
    hasCompletedQuiz = true;
    notifyListeners();
  }

  void resetQuiz() {
    _currentIndex = 0;
    _selectedAnswers = List.filled(questionList.length, null);
    hasCompletedQuiz = false; // ✅ reset this flag
    notifyListeners();
  }
}