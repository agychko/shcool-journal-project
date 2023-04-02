class ApiLesson {
  String? id;
  String? dateTime;
  String? contents;
  String? homeTask;

  ApiLesson(
      {required this.id,
      required this.dateTime,
      required this.contents,
      required this.homeTask});

  ApiLesson.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    dateTime = json['dateTime'];
    contents = json['contents'];
    homeTask = json['homeTask'];
  }

  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime,
      'contents': contents,
      'homeTask': homeTask,
    };
  }
}

class ApiLessonsList {
  final List<ApiLesson> apiLessons = [];
  ApiLessonsList.fromJson(List<dynamic> jsonItems) {
    for (var jsonItem in jsonItems) {
      apiLessons.add(ApiLesson.fromJson(jsonItem));
    }
  }
}
