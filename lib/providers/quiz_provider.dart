import 'package:flutter/material.dart';
import '../data/question_data.dart';
import '../model/question.dart';

class QuizProvider extends ChangeNotifier {
  String name = '';
  String studentClass = '';

  int _currentIndex = 0;
  // selectedAnswers menyimpan index jawaban yang dipilih per soal (null jika belum jawab)
  List<int?> _selectedAnswers = List.filled(questionList.length, null);

  // getter dasar
  int get currentIndex => _currentIndex;
  Question get currentQuestion => questionList[_currentIndex];
  List<int?> get selectedAnswers => _selectedAnswers;
  int get totalQuestions => questionList.length;

  // Score = jumlah jawaban benar (dihitung saat diminta)
  int get score => correct;

  // ✅ Hitung correct secara *derivatif* dari selectedAnswers
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

  // ✅ Jumlah answered yang tidak null
  int get answered {
    return _selectedAnswers.where((s) => s != null).length;
  }

  // ✅ Wrong = answered - correct
  int get wrong => answered - correct;

  // ✅ Completion (%), aman dari divide-by-zero
  int get completion {
    if (totalQuestions == 0) return 0;
    return ((answered / totalQuestions) * 100).toInt();
  }

  // Set player info
  void setPlayerInfo(String newName, String newClass) {
    name = newName;
    studentClass = newClass;
    notifyListeners();
  }

  // Pilih jawaban (menimpa jawaban sebelumnya jika diganti)
  void selectAnswer(int index) {
    _selectedAnswers[_currentIndex] = index;
    notifyListeners(); // UI akan ambil getters terbaru (correct/wrong/completion)
  }

  // Move next (tidak mengubah counters; getters akan menyesuaikan)
  void nextQuestion() {
    if (_currentIndex < questionList.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  // Move previous
  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  // Hitung skor (opsional) — di sini hanya memicu notify jika ingin pakai explicitly
  void calculateScore() {
    // Karena score adalah getter yang dihitung dari selectedAnswers,
    // tidak perlu men-set apa-apa. Tapi kita tetap notify agar UI yang bergantung pada score rebuild.
    notifyListeners();
  }

  void resetQuiz() {
    _currentIndex = 0;
    _selectedAnswers = List.filled(questionList.length, null);
    notifyListeners();
  }
}