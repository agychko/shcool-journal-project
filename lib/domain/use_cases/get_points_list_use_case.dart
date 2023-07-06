
import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/domain/entities/point.dart';
import 'package:journal/domain/repositories/points_repository.dart';

class GetPointsListUseCase {
  final PointsRepository _pointsRepository;

  GetPointsListUseCase(this._pointsRepository);

  Future<DataResponse<List<Point>>> call() =>
      _pointsRepository.getPointsList();
}