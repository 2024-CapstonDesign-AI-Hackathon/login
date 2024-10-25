import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  void _openFile() async {
    // 권한 상태 확인 후 파일 선택
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

  Future<void> requestStoragePermission() async {
    // 저장소 권한 요청
    PermissionStatus status = await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      // 권한이 승인되었을 때 실행할 코드
      print("저장소 권한이 승인되었습니다.");
    } else if (status.isDenied) {
      // 권한이 거부되었을 때 실행할 코드
      print("저장소 권한이 거부되었습니다.");
    } else if (status.isPermanentlyDenied) {
      // 권한이 영구적으로 거부되었을 때, 설정으로 안내하는 코드
      print("저장소 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해주세요.");
      openAppSettings(); // 앱 설정 화면으로 이동
    }
  }

  void initState() {
    super.initState();
    requestStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Chat",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: 10, // 샘플 메시지 수
              itemBuilder: (context, index) {
                bool isMe = index % 2 == 0; // 홀수/짝수로 사용자 메시지 구분
                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      isMe ? "My message $index" : "Other message $index",
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.upload,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () async {
                    // _openFile();
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(allowMultiple: true);

                    if (result != null) {
                      List<File> files =
                          result.paths.map((path) => File(path!)).toList();
                    } else {
                      // User canceled the picker
                    }
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
