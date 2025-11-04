import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget{
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context){
    final quiz = context.read<QuizProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Your Result")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your Score",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Text(
                "${quiz.score}/${quiz.selectedAnswers.length}",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.blue),
              ),
              const SizedBox(height: 30),
              Text(
                "Great Job! You Did It!",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (route) => false,
                  );
                },
                child: const Text("Back to Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}