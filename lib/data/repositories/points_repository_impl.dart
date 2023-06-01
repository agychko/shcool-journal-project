import 'package:journal/data/sources/remote/point_api_source.dart';

import '../../domain/entities/point.dart';
import '../../domain/repositories/points_repository.dart';
import '../models/response/data_response.dart';

class PointsRepositoryImpl extends PointsRepository {
  final PointApiSource _pointApiSource;

  PointsRepositoryImpl(this._pointApiSource);

  @override
  Future<DataResponse<List<Point>>> getPointsList() async {
    var pointResponse = await _pointApiSource.getPointsList();
    if (pointResponse.isSuccess()) {
      var pointsList = pointResponse.asSuccess().data;
      return DataResponse.success(pointsList);
    } else {
      return DataResponse.error(pointResponse.asError().errorMessage);
    }
  }

  @override
  void setApiPoint(Point point) async {
    _pointApiSource.setApiPoint(point);
  }

}