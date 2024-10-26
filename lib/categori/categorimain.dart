import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../chat.dart'; // 챗봇 페이지
import '../summary_page.dart'; // 요약 페이지
import '../question/question1.dart'; // 객관식 페이지
import '../question/question2.dart'; // 단답식 페이지
import '../question/question3.dart'; // 서술형 페이지

class Categorilist extends StatefulWidget {
  @override
  Categorilist({super.key});

  @override
  _ClassroomListState createState() => _ClassroomListState();
}

class _ClassroomListState extends State<Categorilist> {
  @override
  void initState() {
    super.initState();
    requestStoragePermission(); // 권한 요청
  }

  void _openFile() async {
    PermissionStatus status = await Permission.storage.status;

    if (status.isGranted) {
      try {
        FilePickerResult? result =
            await FilePicker.platform.pickFiles(allowMultiple: true);

        if (result != null && result.files.isNotEmpty) {
          List<File> files = result.paths.map((path) => File(path!)).toList();
          print("선택된 파일 경로: ${files}");
          // 선택된 파일을 처리하는 추가 로직을 여기에 추가할 수 있습니다.
          // 예를 들어, 파일 리스트를 보여주는 다이얼로그 등으로 처리할 수 있습니다.
        } else {
          print('파일이 선택되지 않았습니다.');
        }
      } catch (e) {
        print("파일 선택 중 오류 발생: $e");
      }
    } else {
      print('저장소 권한이 없습니다. 권한을 허용해주세요.');
      await requestStoragePermission();
    }
  }

  Future<void> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      print("저장소 권한이 승인되었습니다.");
    } else if (status.isDenied) {
      print("저장소 권한이 거부되었습니다.");
      // 필요시 사용자에게 권한 요청을 다시 할 수 있습니다.
    } else if (status.isPermanentlyDenied) {
      print("저장소 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해주세요.");
      openAppSettings();
    }
  }

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
        actions: [
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () {
              _openFile(); // 파일 선택 함수 호출
            },
          ),
        ],
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
                    _buildCategoryCard("요약", SummaryPage()),
                    _buildCategoryCard("객관식", QuestionScreen1()),
                    _buildCategoryCard("단답식", QuestionScreen2()),
                    _buildCategoryCard("서술형", QuestionScreen3()),
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
                      MaterialPageRoute(
                          builder: (context) => page), // 각 카테고리 페이지로 이동
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
