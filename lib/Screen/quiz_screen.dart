import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'result_screen.dart';
import '../data/question_data.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<QuizProvider>(context);
    final currentQuestion = quiz.currentQuestion;
    final selectedIndex = quiz.selectedAnswers[quiz.currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFFFEAEA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFEAEA),
        title: const Text('ART'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Question Container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question header (number + quit)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Question: ${quiz.currentIndex + 1}/${questionList.length}",
                        style: const TextStyle(
                          color: Color(0xFF345C4C),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          "Quit",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Question text
                  Text(
                    currentQuestion.question,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Options (styled like buttons)
                  Column(
                    children: List.generate(currentQuestion.options.length, (index) {
                      final isSelected = selectedIndex == index;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: () => quiz.selectAnswer(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF345C4C)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF345C4C)
                                    : Colors.grey.shade300,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              currentQuestion.options[index],
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Navigation Buttons (below card)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: quiz.currentIndex > 0
                      ? () => quiz.previousQuestion()
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF345C4C),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey,
                    minimumSize: const Size(120, 45),
                  ),
                  child: const Text("Previous"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (quiz.currentIndex < questionList.length - 1) {
                      quiz.nextQuestion();
                    } else {
                      quiz.calculateScore();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ResultScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF345C4C),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(120, 45),
                  ),
                  child: Text(
                    quiz.currentIndex < questionList.length - 1
                        ? "Next"
                        : "See Result",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}