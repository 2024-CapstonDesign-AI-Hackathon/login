import 'package:flutter/material.dart';
import '../chat.dart'; // 챗봇 페이지
import '../question/question1.dart'; // 객관식 페이지
import '../question/question2.dart'; // 단답식 페이지
import '../question/question3.dart'; // 서술형 페이지

class SummaryPage extends StatelessWidget {
  final String courseName; // 수업명
  final String summaryContent; // 요약 내용

  SummaryPage(
      {Key? key, required this.courseName, required this.summaryContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$courseName 요약'), // 앱바에 수업명 + 요약 표시
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // 뒤로가기 아이콘
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
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                '메뉴',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
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
                  MaterialPageRoute(builder: (context) => QuestionScreen1()), // 객관식 페이지
                );
              },
            ),
            ListTile(
              title: Text('단답식 문제'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuestionScreen2()), // 단답식 페이지
                );
              },
            ),
            ListTile(
              title: Text('서술형 문제'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuestionScreen3()), // 서술형 페이지
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
                    summaryContent,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
