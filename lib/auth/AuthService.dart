import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front/Api.dart';
import 'package:front/auth/token.dart';
import 'package:front/domain/user.dart';
import 'package:front/service/UserService.dart';

class AuthService with ChangeNotifier {
  late Userservice userservice;
  final storage = FlutterSecureStorage();
  final dio = Dio();
  Token? token; // 토큰 저장 삭제
  Api? api; // 추후 api url 지정

  //로그인 요청 id, pw parameter
  //로그인 성공 시 회원 정보 저장
  Future loginRequest(String email, String password) async {
    Response response;

    if (email != null && password != null) {
      response = await dio.post(
        'url',
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        String access = response.headers['authorization'] as String;
        token?.saveToken(access);

        User user =
            User.fromJson(response.data.toString() as Map<String, dynamic>);
        userservice.user = user;
      } else {
        print("에러");
      }
    }
  }
}
