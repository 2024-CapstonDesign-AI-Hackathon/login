import 'package:flutter/material.dart';

class QuestionScreen2 extends StatefulWidget {
  @override
  _QuestionScreen2State createState() => _QuestionScreen2State();
}

class _QuestionScreen2State extends State<QuestionScreen2> {
  final TextEditingController _answerController = TextEditingController();

  @override
  void dispose() {
    _answerController.dispose(); // 메모리 누수를 방지
    super.dispose();
  }

  void _submitAnswer() {
    String answer = _answerController.text.trim();

    if (answer.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('답변이 제출되었습니다: $answer')),
      );
      _answerController.clear(); // 제출 후 입력 필드 초기화
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('답변을 입력하세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('단답형 문제'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 문제 텍스트
            Text(
              '문제: Flutter에서 상태 관리를 위해 주로 사용하는 클래스는?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // 단답 입력 필드
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                hintText: '답변을 입력하세요',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 30),

            // 정답 제출 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitAnswer,
                child: Text(
                  '정답 제출',
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
