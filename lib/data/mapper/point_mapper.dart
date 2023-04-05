import 'package:journal/data/remote/model/api_point.dart';

import '../../domain/entities/point.dart';

class PointMapper {
  static Point fromApi(ApiPoint apiPoint) {
    return Point(
      id: apiPoint.id!,
      value: apiPoint.value!.toString(),
      lessonId: apiPoint.lessonId!,
      userId: apiPoint.userId!,
    );
  }

  static ApiPoint toApi(Point point) {
    return ApiPoint(
        id: point.id,
        userId: point.userId,
        lessonId: point.lessonId,
        value: int.parse(point.value),
    );
  }
}
