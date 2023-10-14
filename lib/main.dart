import 'package:flutter/material.dart';
import 'package:proyecto_m4/pages/answer_page.dart';
import 'package:proyecto_m4/pages/questions_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
     debugShowCheckedModeBanner: false,
     initialRoute: "/",
     routes: {
        "/": (context) => const QuestionPage(),
        "/answer": (context) =>  AnwserPage( answer: ModalRoute.of(context)!.settings.arguments.toString()), 
     } ,
    );
  }
} 