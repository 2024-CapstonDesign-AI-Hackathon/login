import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:front/service/upload.dart';
import 'package:permission_handler/permission_handler.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
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
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Chat",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // 드로어 열기
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 80, // 원하는 높이로 설정
              child: DrawerHeader(
                child: Text(
                  '챗봇 히스토리',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                decoration: BoxDecoration(
                  color: Colors.blueAccent, // 배경색 설정
                ),
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(16.0),
              ),
            ),
            ListTile(
              title: Text('히스토리 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('히스토리 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('히스토리 3'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: 10, // 샘플 메시지 수
              itemBuilder: (context, index) {
                bool isMe = index % 2 == 0;
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
                    _openFile();
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
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
