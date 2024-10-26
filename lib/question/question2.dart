import 'package:flutter/material.dart';

class Question {
  final String questionText;
  final String correctAnswer;

  Question({
    required this.questionText,
    required this.correctAnswer,
  });
}

class QuestionScreen2 extends StatefulWidget {
  @override
  _QuestionScreen2State createState() => _QuestionScreen2State();
}

class _QuestionScreen2State extends State<QuestionScreen2> {
  final List<Question> _questions = [
    Question(
      questionText: '문제: Flutter에서 상태 관리를 위해 주로 사용하는 클래스는?',
      correctAnswer: 'Provider',
    ),
    Question(
      questionText: '문제: Flutter의 기본 UI 구성 요소는?',
      correctAnswer: 'Widget',
    ),
    Question(
      questionText: '문제: Flutter에서 비동기 처리를 위해 사용하는 키워드는?',
      correctAnswer: 'async',
    ),
    Question(
      questionText: '문제: Flutter에서 애니메이션을 구현하기 위해 사용하는 기본 클래스는?',
      correctAnswer: 'AnimationController',
    ),
    Question(
      questionText: '문제: Flutter에서 HTTP 요청을 보내기 위해 주로 사용하는 패키지는?',
      correctAnswer: 'http',
    ),
    Question(
      questionText: '문제: Flutter의 hot reload 기능은 무엇인가요?',
      correctAnswer: 'UI를 즉시 업데이트',
    ),
    Question(
      questionText: '문제: Flutter에서 상태 관리를 위한 라이브러리는?',
      correctAnswer: 'Provider',
    ),
    Question(
      questionText: '문제: Flutter의 주요 디자인 언어는 무엇인가요?',
      correctAnswer: 'Material Design',
    ),
    Question(
      questionText: '문제: Flutter에서 비동기 프로그래밍을 위한 클래스는?',
      correctAnswer: 'Future',
    ),
    Question(
      questionText: '문제: Flutter에서 위젯 트리를 업데이트하기 위해 사용하는 메서드는?',
      correctAnswer: 'setState',
    ),
  ];

  final TextEditingController _answerController = TextEditingController();
  int _currentPage = 0;
  bool _isSubmitted = false;

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
      setState(() {
        _isSubmitted = true; // 정답 제출 상태 업데이트
      });
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
        title: Text('단답식 문제', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: PageView.builder(
        itemCount: _questions.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
            _isSubmitted = false; // 페이지가 바뀔 때 제출 상태 초기화
            _answerController.clear(); // 입력 필드 초기화
          });
        },
        itemBuilder: (context, index) {
          final question = _questions[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 문제 텍스트
                Text(
                  question.questionText,
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
                if (_isSubmitted)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      '정답: ${question.correctAnswer}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
