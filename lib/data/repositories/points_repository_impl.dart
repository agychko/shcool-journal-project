import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/data/sources/local/preferences_source.dart';
import 'package:journal/data/sources/remote/points_source.dart';
import 'package:journal/domain/entities/point.dart';
import 'package:journal/domain/repositories/points_repository.dart';

class PointsRepositoryImpl extends PointsRepository {
  final PointsSource _pointsSource;
  final PreferencesSource _preferencesSource;

  PointsRepositoryImpl(this._pointsSource, this._preferencesSource);

  @override
  Future<DataResponse<List<Point>>> getPointsList() async {
    String accessToken = await _preferencesSource.getAccessToken() ?? '';
    var pointResponse = await _pointsSource.getPointsList(accessToken);
    if (pointResponse.isSuccess()) {
      var pointsList = pointResponse.asSuccess().data;
      return DataResponse.success(pointsList);
    } else {
      return DataResponse.error(pointResponse.asError().errorMessage);
    }
  }

  @override
  void setPoint(Point point) async {
    String accessToken = await _preferencesSource.getAccessToken() ?? '';
    _pointsSource.setApiPoint(accessToken, point);
  }
}
