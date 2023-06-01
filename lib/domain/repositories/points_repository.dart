import 'package:journal/domain/entities/point.dart';

import '../../data/models/response/data_response.dart';

abstract class PointsRepository {
  Future<DataResponse<List<Point>>> getPointsList();
  void setApiPoint(Point point);
}