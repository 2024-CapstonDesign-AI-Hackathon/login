import 'package:front/domain/lecture.dart';
import 'package:front/domain/user.dart';

class chatbots {
  int? id;
  String question;
  String response;
  User user;
  Lecture lecture;
  DateTime createdAt;

  chatbots(this.id, this.question, this.response, this.user, this.lecture,
      this.createdAt);

  
}
