import 'package:flutter/material.dart';
import 'package:front/Api.dart';
import 'package:front/auth/token.dart';
import 'package:front/domain/lecture.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LectureService with ChangeNotifier {
  List<Lecture> classroomList = [];
  late Token token;
  late Api api;
  // 추가
  void addList(List<Lecture> lectureList) {
    for (int i = 0; i < lectureList.length; i++) {
      classroomList.add(lectureList[i]);
    }
    notifyListeners();
  }

  //강의 추가  요청
  Future<void> lectureRequest() async {
    String? access = await token.getToken();
    var response = await http.get(
      Uri.parse(api.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody =
          jsonDecode(utf8.decode(response.bodyBytes));

      Lecture lecture = Lecture.fromJson(responseBody);
      classroomList.add(lecture);
      notifyListeners();
    }
  }
}
