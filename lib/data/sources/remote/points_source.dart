
import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/domain/entities/point.dart';

abstract class PointsSource {

  Future<DataResponse<List<Point>>> getPointsList(String? accessToken);

  void setApiPoint(String? accessToken, Point point);
}