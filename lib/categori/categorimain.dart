import 'package:flutter/material.dart';

// 이미 작성된 페이지를 import합니다.
import '../chat.dart'; // 챗봇 페이지
//import 'summary_page.dart'; // 요약 페이지
import '../question/question1.dart'; // 객관식 페이지
import '../question/question2.dart'; // 단답식 페이지
import '../question/question3.dart'; // 서술형 페이지
//import 'learning_management.dart'; // 학습관리 페이지

class Categorilist extends StatefulWidget {
  @override
  Categorilist({super.key});

  @override
  _ClassroomListState createState() => _ClassroomListState();
}

class _ClassroomListState extends State<Categorilist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ), // 뒤로가기 아이콘
          onPressed: () {
            Navigator.pop(context); // 이전 화면으로 이동
          },
        ),
        title: Text(
          "수업1",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              child: Text(
                "카테고리",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(height: 30, thickness: 3),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 고정된 카드 6개
                    _buildCategoryCard("챗봇", Chat()),
                    //_buildCategoryCard("요약", summary()),
                    _buildCategoryCard("객관식", QuestionScreen1()),
                    _buildCategoryCard("단답식", QuestionScreen2()),
                    _buildCategoryCard("서술형", QuestionScreen3()),
                    //_buildCategoryCard("학습관리", LearningManagementPage()),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // 카테고리 카드 생성 함수
  Widget _buildCategoryCard(String title, Widget page) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4.0, // 그림자 깊이
        child: Container(
          height: 90,
          width: 350,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 25),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => page), // 각 카테고리 페이지로 이동
                    );
                  },
                  child: Text(
                    "입장",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
