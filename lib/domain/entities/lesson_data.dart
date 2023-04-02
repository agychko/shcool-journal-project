class LessonData {
  final DateTime dateTime;
  final String contents;
  final String homeTask;

  LessonData({
    required this.dateTime,
    required this.contents,
    required this.homeTask,
  });

  LessonData copy ({
    DateTime? dateTime,
    String? contents,
    String? homeTask,
}) =>
      LessonData(
          dateTime: dateTime ?? this.dateTime,
          contents: contents ?? this.contents,
          homeTask: homeTask ?? this.homeTask
      );
}