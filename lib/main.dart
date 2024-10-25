import 'package:flutter/material.dart';
import '../login.dart';
import '../question1.dart'; //객관식
import '../question2.dart'; //단답식
import '../question3.dart'; //서술형

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Study Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuestionScreen3(), // LoginScreen을 초기 화면으로 설정
    );
  }
}
