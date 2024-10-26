class Summaries {
  int id;
  String content_url;
  DateTime createdAt;
  int lecture_id;

  Summaries(this.id, this.content_url, this.createdAt, this.lecture_id);

  factory Summaries.fromJson(Map<String, dynamic> json) {
    return Summaries(
        json['id'], json['content_url'], json['createdAt'], json['lecture_id']);
  }

  
}
