import 'package:front/domain/user.dart';

class Lecture {
  int id;
  String title;
  String content_url;
  DateTime createdAt;
  User user;

  Lecture(this.id, this.title, this.content_url, this.createdAt, this.user);

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(json['id'], json['title'], json['content_url'],
        json['createdAt'], json['user']);
  }
}
