class ApiPoint {
  String? id;
  String? userId;
  String? lessonId;
  int? value;

  ApiPoint({
    required this.id,
    required this.userId,
    required this.lessonId,
    required this.value
});

  ApiPoint.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    userId = json['userId'];
    lessonId = json['lessonId'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'lessonId': lessonId,
      'value': value,
    };
  }
}

class ApiPointsList {
  final List <ApiPoint> apiPoints = [];
  ApiPointsList.fromJson(List<dynamic> jsonItems) {
    for (var jsonItem in jsonItems) {
      apiPoints.add(ApiPoint.fromJson(jsonItem));
    }
  }
}