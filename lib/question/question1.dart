import 'package:flutter/material.dart';

class QuestionScreen1 extends StatefulWidget {
  @override
  _QuestionScreen1State createState() => _QuestionScreen1State();
}

class _QuestionScreen1State extends State<QuestionScreen1> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('객관식 문제'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 문제 텍스트
            Text(
              '문제: 다음 중 Flutter의 주요 언어는 무엇입니까?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // 객관식 선택지
            Column(
              children: [
                RadioListTile<String>(
                  title: Text('A. Java'),
                  value: 'Java',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('B. Dart'),
                  value: 'Dart',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('C. Swift'),
                  value: 'Swift',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('D. Kotlin'),
                  value: 'Kotlin',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 30),

            // 정답 제출 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedOption != null) {
                    // 정답 제출 로직 추가
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$_selectedOption 선택됨')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('옵션을 선택해주세요.')),
                    );
                  }
                },
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
