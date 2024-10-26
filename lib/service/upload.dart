import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front/Api.dart';
import 'package:front/auth/token.dart';
import 'package:front/domain/summaries.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Upload {
  Api api = new Api();
  final storage = FlutterSecureStorage();
  Upload();

  //강의 자료 전송
  Future<Summaries?> dateRequest(File? file) async {
    try {
      if (file != null) {
        String? access = await storage.read(key: 'Authorization');
        var response = await http.post(
          Uri.parse(api.toString()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': access.toString(),
          },
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> responseBody =
              jsonDecode(utf8.decode(response.bodyBytes));
          Summaries summaries = Summaries.fromJson(responseBody);
          return summaries;
        }
        print("dateRequest 메소드 에러");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<File?> openFile() async {
    PermissionStatus status = await Permission.storage.status;

    if (status.isGranted) {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles();

        if (result != null) {
          File file = File(result.files.single.path!);
          return file;
        } else {
          // User canceled the picker
          return null;
        }
      } catch (e) {
        print("파일 선택 중 오류 발생: $e");
      }
    } else {
      print('저장소 권한이 없습니다. 권한을 허용해주세요.');
      await requestStoragePermission();
      return null;
    }
  }

  Future<void> requestStoragePermission() async {
    PermissionStatus status = await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      print("저장소 권한이 승인되었습니다.");
    } else if (status.isDenied) {
      print("저장소 권한이 거부되었습니다.");
    } else if (status.isPermanentlyDenied) {
      print("저장소 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해주세요.");
      openAppSettings();
    }
  }
}
