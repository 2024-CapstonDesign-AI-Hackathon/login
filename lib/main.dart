import 'package:flutter/material.dart';
import 'package:front/categori/summary_page.dart';
import 'package:front/domain/summaries.dart';
import 'package:front/service/ClassroomService.dart';
import 'package:front/service/UserService.dart';
import 'package:front/service/summariesService.dart';
import 'package:provider/provider.dart';
import 'package:front/ClassroomList.dart';
import 'package:front/chat.dart';
import 'package:permission_handler/permission_handler.dart';
import '../categori/categorimain.dart';
import '../login.dart';
import '../question/question1.dart'; //객관식
import '../question/question2.dart'; //단답식
import '../question/question3.dart'; //서술형

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LectureService()),
        ChangeNotifierProvider(create: (context) => SummariesService()),
        ChangeNotifierProvider(create: (context) => Userservice()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white, // 전체 앱의 Scaffold 배경색을 흰색으로 설정
          dialogBackgroundColor: Colors.white,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
