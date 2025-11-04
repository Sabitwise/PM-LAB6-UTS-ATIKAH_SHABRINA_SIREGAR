import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_provider.dart';
import 'Screen/home_screen.dart';

void main(){
  runApp(const ArtQuizApp());
}

class ArtQuizApp extends StatelessWidget{
  const ArtQuizApp({super.key});

  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Art Quiz",
        // themeMode: ThemeMode.system,
        // theme: ThemeData(
        //   brightness: Brightness.light,
        //   fontFamily: "Poppins",
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        // ),
        // darkTheme: ThemeData(
        //   brightness: Brightness.dark,
        //   fontFamily: "Poppins",
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        // ),
        home: const HomeScreen(),
      ),
    );
  }
}