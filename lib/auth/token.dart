import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Token {
  final storage = FlutterSecureStorage();

  // 토큰 불러오기
  Future<void> saveToken(String token) async {
    await storage.write(key: 'Authorization', value: token);
  }

  // 토큰 가져오기
  Future<String?> getToken() async {
    // FlutterSecureStorage에서 토큰 불러오기
    return await storage.read(key: 'Authorization');
  }

  // 토큰 삭제
  Future<void> deleteToken() async {
    await storage.delete(key: 'Authorization');
  }
}
