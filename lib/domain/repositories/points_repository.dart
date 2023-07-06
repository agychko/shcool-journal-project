import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/domain/entities/point.dart';

abstract class PointsRepository {
  Future<DataResponse<List<Point>>> getPointsList();

  void setPoint(Point point);
}
