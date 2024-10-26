import 'package:flutter/material.dart';
import 'package:front/ClassroomList.dart';
import 'package:front/chat.dart';
import 'package:permission_handler/permission_handler.dart';
import '../login.dart';
import 'qustion/question1.dart'; //객관식
import 'qustion/question2.dart'; //단답식
import 'qustion/question3.dart'; //서술형

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white, // 전체 앱의 Scaffold 배경색을 흰색으로 설정
        dialogBackgroundColor: Colors.white,
      ),
      home: Chat(),
    );
  }
}
