class Lesson {
  final String id;
  final DateTime dateTime;
  final String contents;
  final String homeTask;

  Lesson({
    required this.id,
    required this.dateTime,
    required this.contents,
    required this.homeTask,
  });

  Lesson copy({
    String? id,
    DateTime? dateTime,
    String? contents,
    String? homeTask,
  }) =>
      Lesson(
          id: id ?? this.id,
          dateTime: dateTime ?? this.dateTime,
          contents: contents ?? this.contents,
          homeTask: homeTask ?? this.homeTask
      );
}
