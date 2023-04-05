class Point {
  final String id;
  final String value;
  final String lessonId;
  final String userId;

  const Point ({
    required this.id,
    required this.value,
    required this.lessonId,
    required this.userId,
});

  Point copy({
    String? id,
    String? value,
    String? lessonId,
    String? userId,
  }) =>
      Point(
        id: id ?? this.id,
        value: value ?? this.value,
        lessonId: lessonId ?? this.lessonId,
        userId: userId ?? this.userId,
      );

}