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
        var request = http.MultipartRequest('POST', Uri.parse(api.toString()));

        request.headers.addAll(<String, String>{
          'Authorization': access.toString(),
        });
        request.files.add(await http.MultipartFile.fromPath('file', file.path));

        var response = await request.send();
        if (response.statusCode == 200) {
          var responseBody = await response.stream.bytesToString();
          Summaries summaries = Summaries.fromJson(jsonDecode(responseBody));
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
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: ['mp3', 'pdf', 'doc'],
        );
        print("check");
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
      openAppSettings();
    } else if (status.isPermanentlyDenied) {
      print("저장소 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해주세요.");
      openAppSettings();
    }
  }
}
