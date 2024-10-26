import 'package:flutter/material.dart';
import 'package:front/chat.dart';
import 'package:front/question/question1.dart';
import 'package:front/question/question2.dart';
import 'package:front/question/question3.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String courseName = 'dsdsd'; // 수업명
    String summaryContent; // 요약 내용
    return Scaffold(
      appBar: AppBar(
        title: Text('$courseName 요약', style: TextStyle(color: Colors.white)), // 앱바에 수업명 + 요약 표시
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // 뒤로가기 아이콘
          onPressed: () {
            Navigator.pop(context); // 이전 화면으로 이동
          },
        ),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu), // 메뉴 아이콘
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Drawer 열기
                },
              );
            },
          ),
        ],
      ),drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 80.0, // 원하는 높이로 설정
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                '메뉴',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(16.0),
            ),
          ),
          ListTile(
            title: Text('챗봇'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Chat()), // 챗봇 페이지
              );
            },
          ),
          ListTile(
            title: Text('객관식 문제'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuestionScreen1()), // 객관식 페이지
              );
            },
          ),
          ListTile(
            title: Text('단답식 문제'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuestionScreen2()), // 단답식 페이지
              );
            },
          ),
          ListTile(
            title: Text('서술형 문제'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuestionScreen3()), // 서술형 페이지
              );
            },
          ),
        ],
      ),
    ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 과목 제목
            Text(
              courseName,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            // 요약 내용
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Container(
                height: 800, // 원하는 높이 설정
                child: Chat(), // 챗봇 페이지를 모달 하단 시트로 표시
              );
            },
          );
        },
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF5b6ab8),
      ),
    );
  }
}
