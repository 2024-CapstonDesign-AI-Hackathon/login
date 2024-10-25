import 'package:flutter/material.dart';

class QuestionScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('서술형문제'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 문제 텍스트
            Text(
              '문제: 1.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '자고싶을떈 어떻게 하나요.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),

            // 답변 입력 필드
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: '답변을 입력하세요',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),

            // 정답 제출 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // 정답 제출 로직 추가
                },
                child: Text(
                  '제출',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
