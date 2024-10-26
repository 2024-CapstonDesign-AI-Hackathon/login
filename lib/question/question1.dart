import 'package:flutter/material.dart';

class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
  });
}

class QuestionScreen1 extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen1> {
  final List<Question> _questions = [    Question(      questionText: '문제: 다음 중 Flutter의 주요 언어는 무엇입니까?',      options: ['A. Java', 'B. Dart', 'C. Swift', 'D. Kotlin'],
    correctAnswer: 'B. Dart',
  ),
    Question(
      questionText: '문제: Flutter에서 UI 구성 요소를 무엇이라고 합니까?',
      options: ['Widget', 'Component', 'Element', 'Module'],
      correctAnswer: 'Widget',
    ),
    // 추가 문제를 여기에 추가...
    Question(
      questionText: '문제: Flutter의 상태 관리는 무엇을 의미하나요?',
      options: ['StatefulWidget', 'StatelessWidget', 'Provider', 'Bloc'],
      correctAnswer: 'StatefulWidget',
    ),
    Question(
      questionText: '문제: Flutter에서 기본적인 레이아웃을 구성하는 위젯은?',
      options: ['Row', 'Column', 'Container', 'Stack'],
      correctAnswer: 'Column',
    ),
    Question(
      questionText: '문제: Flutter에서 비동기 처리를 위해 사용하는 키워드는?',
      options: ['async', 'await', 'Future', '모두 포함'],
      correctAnswer: '모두 포함',
    ),
    Question(
      questionText: '문제: Flutter의 hot reload 기능은 무엇인가요?',
      options: ['앱을 재시작', 'UI를 즉시 업데이트', '디버깅', '패키지 업데이트'],
      correctAnswer: 'UI를 즉시 업데이트',
    ),
    Question(
      questionText: '문제: Flutter에서 애니메이션을 구현하기 위한 기본 클래스는?',
      options: ['Animation', 'AnimatedWidget', 'Tween', 'AnimationController'],
      correctAnswer: 'AnimationController',
    ),
    Question(
      questionText: '문제: Flutter에서 HTTP 요청을 보내기 위해 주로 사용하는 패키지는?',
      options: ['http', 'dio', 'flutter_http', 'url_launcher'],
      correctAnswer: 'http',
    ),
    Question(
      questionText: '문제: Flutter에서 상태 관리를 위한 라이브러리는?',
      options: ['Provider', 'Riverpod', 'BLoC', '모두 포함'],
      correctAnswer: '모두 포함',
    ),
    Question(
      questionText: '문제: Flutter의 기본 UI 디자인 언어는?',
      options: ['Material Design', 'Flat Design', 'Neumorphism', '3D Design'],
      correctAnswer: 'Material Design',
    ),
  ];

  int _currentPage = 0;
  String? _selectedOption;
  bool _isSubmitted = false;

  void _submitAnswer() {
    setState(() {
      _isSubmitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('객관식 문제'),
        centerTitle: true,
      ),
      body: PageView.builder(
        itemCount: _questions.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
            _isSubmitted = false; // 페이지가 바뀔 때 제출 상태 초기화
            _selectedOption = null; // 선택된 옵션 초기화
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

                // 객관식 선택지
                Column(
                  children: question.options.map((option) {
                    return RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 30),

                // 정답 제출 버튼
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedOption != null) {
                        _submitAnswer();
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
