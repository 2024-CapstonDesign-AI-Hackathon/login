import 'package:flutter/material.dart';
import '../login.dart';
import '../question.dart';

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
      home: DescriptiveQuestionScreen(), // LoginScreen을 초기 화면으로 설정
    );
  }
}
