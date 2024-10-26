import 'package:flutter/material.dart';
import 'package:front/domain/summaries.dart';

class SummariesService with ChangeNotifier {
  List<Summaries> summeriesList = [];

  //추가
  void addSummires(Summaries summaries) {
    summeriesList.add(summaries);
    notifyListeners();
  }
}
