class LessonData {
  final String id;
  final DateTime dateTime;
  final String contents;
  final String homeTask;

  LessonData({
    required this.id,
    required this.dateTime,
    required this.contents,
    required this.homeTask,
  });

  LessonData copy({
    String? id,
    DateTime? dateTime,
    String? contents,
    String? homeTask,
  }) =>
      LessonData(
          id: id ?? this.id,
          dateTime: dateTime ?? this.dateTime,
          contents: contents ?? this.contents,
          homeTask: homeTask ?? this.homeTask
      );
}
