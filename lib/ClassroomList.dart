import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'summary_page.dart';

class ClassroomList extends StatefulWidget {
  @override
  // TODO: implement key
  ClassroomList({super.key});

  @override
  _ClassroomListState createState() => _ClassroomListState();
}

class _ClassroomListState extends State<ClassroomList> {
  ScrollController? _controller;
  List<String> _courses = []; // 수업명 리스트 추가

  Future<void> requestStoragePermission() async {
    PermissionStatus status = await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      print("저장소 권한이 승인되었습니다.");
    } else if (status.isDenied) {
      print("저장소 권한이 거부되었습니다.");
      openAppSettings();
    } else if (status.isPermanentlyDenied) {
      print("저장소 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해주세요.");
      openAppSettings();
    }
  }

  void _openFile() async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isGranted) {
      try {
        FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
        if (result != null && result.files.single.path != null) {
          List<File> files = result.paths.map((path) => File(path!)).toList();
          print("선택된 파일 경로: ${files}");
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

  void _showAddCourseDialog() {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 다이얼로그 크기 자동 조정
              children: [
                Text(
                  "수업명 입력",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(hintText: "수업명을 입력하세요"),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end, // 버튼을 오른쪽 정렬
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      },
                      child: Text("취소",
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          setState(() {
                            _courses.add(_controller.text); // 리스트에 수업명 추가
                          });
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                        }
                      },
                      child: Text("확인",
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // 이전 화면으로 이동
          },
        ),
        title: Text("Classroom List", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Icon(Icons.person, color: Colors.black, size: 60),
                      ),
                      Column(
                        children: [
                          Text("환영합니다.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("admin님", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.logout, size: 40, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              child: Text("수업 목록", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            ),
            Divider(height: 30, thickness: 3),
            Expanded(
              child: ListView.builder(
                itemCount: _courses.length,
                itemBuilder: (BuildContext context, int idx) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation: 4.0,
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SummaryPage()),
                        );
                      },
                      child: Container(
                        height: 90,
                        width: 350,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _courses[idx], // 수업명 표시
                              style: TextStyle(fontSize: 25, color: Colors.black),
                            ),
                            IconButton(
                              onPressed: () {
                                _openFile();
                              },
                              icon: Icon(Icons.cloud_upload_outlined, size: 30),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 25),
            IconButton(
              onPressed: _showAddCourseDialog, // 수업 추가 다이얼로그 열기
              icon: Icon(Icons.add_circle_outline_outlined, color: Color(0xFF5b6ab8), size: 50),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
