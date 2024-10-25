import 'package:front/domain/user.dart';

class Lecture {
  int id;
  String title;
  String content_url;
  DateTime createdAt;
  User user;

  Lecture(this.id, this.title, this.content_url, this.createdAt, this.user);

  
}
