class Point {
  final String value;
  final int date;
  final String userId;

  const Point ({
    required this.value,
    required this.date,
    required this.userId,
});

  Point copy({
    String? value,
    int? date,
    String? userId,
  }) =>
      Point(
        value: value ?? this.value,
        date: date ?? this.date,
        userId: userId ?? this.userId,
      );

}