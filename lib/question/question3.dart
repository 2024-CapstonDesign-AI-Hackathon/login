import 'package:flutter/material.dart';

class Question {
  final String questionText;
  final String correctAnswer;

  Question({
    required this.questionText,
    required this.correctAnswer,
  });
}

class QuestionScreen3 extends StatefulWidget {
  @override
  _QuestionScreen3State createState() => _QuestionScreen3State();
}

class _QuestionScreen3State extends State<QuestionScreen3> {
  final List<Question> _questions = [
    Question(questionText: '문제: 자고 싶을 땐 어떻게 하나요?', correctAnswer: '편안한 환경을 조성한다.'),
    Question(questionText: '문제: Flutter의 주요 특징은 무엇인가요?', correctAnswer: '크로스 플랫폼 개발이 가능하다.'),
    Question(questionText: '문제: 비동기 프로그래밍의 장점은 무엇인가요?', correctAnswer: '응답성을 높일 수 있다.'),
    Question(questionText: '문제: Flutter에서 상태 관리는 어떻게 하나요?', correctAnswer: 'StatefulWidget을 사용한다.'),
    Question(questionText: '문제: Flutter의 위젯 트리에 대해 설명하세요.', correctAnswer: '모든 UI 요소는 위젯으로 구성된다.'),
    Question(questionText: '문제: Flutter의 hot reload 기능은 무엇인가요?', correctAnswer: '코드 변경을 즉시 반영한다.'),
    Question(questionText: '문제: Flutter의 기본 디자인 언어는 무엇인가요?', correctAnswer: 'Material Design'),
    Question(questionText: '문제: Flutter에서 비동기 처리를 어떻게 하나요?', correctAnswer: 'async/await 키워드를 사용한다.'),
    Question(questionText: '문제: Flutter에서 HTTP 요청을 보내는 방법은?', correctAnswer: 'http 패키지를 사용한다.'),
    Question(questionText: '문제: Flutter에서 애니메이션을 구현하는 방법은?', correctAnswer: 'AnimationController를 사용한다.'),  ];

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
        title: Text('서술형 문제', style: TextStyle(color: Colors.white)),
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

                // 답변 입력 필드
                TextField(
                  controller: _answerController,
                  maxLines: 5,
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
                      '제출',
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
