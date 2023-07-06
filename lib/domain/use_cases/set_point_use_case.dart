import 'package:journal/domain/entities/point.dart';
import 'package:journal/domain/repositories/points_repository.dart';

class SetPointUseCase {
  final PointsRepository _pointsRepository;

  SetPointUseCase(this._pointsRepository);

  void call(Point point) => _pointsRepository.setPoint(point);
}
