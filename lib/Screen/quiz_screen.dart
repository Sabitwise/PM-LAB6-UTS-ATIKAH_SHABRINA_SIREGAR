import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/option.dart';
import '../widgets/custome_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget{
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context){
    final quiz = context.watch<QuizProvider>();
    final question = quiz.currentQuestion;
    final selected = quiz.selectedAnswers[quiz.currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Question ${quiz.currentIndex + 1}/${quiz.selectedAnswers.length}"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text(
                    question.question,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                  for (int i = 0; i < question.options.length; i++)
                    Option(
                      text: question.options[i],
                      isSelected: selected == i,
                      onTap: () => quiz.selectAnswer(i),
                    ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  text: "Previous",
                  onPressed: quiz.currentIndex == 0 ? null : () => quiz.previousQuestion(),
                ),
                CustomButton(
                  text: quiz.currentIndex == quiz.selectedAnswers.length - 1 ? "Finish" : "Next",
                  onPressed: (){
                    if(quiz.currentIndex == quiz.selectedAnswers.length - 1){
                      quiz.calculateScore();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ResultScreen(),
                        ),
                      );
                    }else{
                      quiz.nextQuestion();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}