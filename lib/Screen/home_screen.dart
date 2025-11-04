import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:uts_lab_sabrina/providers/quiz_provider.dart';
import '../providers/quiz_provider.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);

    return Scaffold(
    appBar: AppBar(title: const Text("Art Quiz")),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Expanded(
          //   child: Image.asset(
          //     'assets/images/art.png',
          //     fit: BoxFit.contain,
          //   ),
          // ),
          const SizedBox(height: 20),
          Text(
            "Test Your Art Knowledge!",
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            "Are you ready to explore art and creativity?",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: (){
              context.read<QuizProvider>().resetQuiz();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QuizScreen()),
              );
             },
              child: const Text("Start Quiz"),
            ),
           ],
          ),
         ),
        );
      }
    }