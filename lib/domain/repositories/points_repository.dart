import 'package:journal/domain/entities/point.dart';

import '../../data/response/data_response.dart';

abstract class PointsRepository {
  Future<DataResponse<List<Point>>> getPointsList();
  void setApiPoint(Point point);
}