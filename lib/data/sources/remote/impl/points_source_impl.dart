
import 'dart:convert';

import 'package:journal/data/models/mapper/point_mapper.dart';
import 'package:journal/data/models/remote/api_point.dart';
import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/data/sources/remote/points_source.dart';
import 'package:journal/domain/entities/point.dart';
import 'package:http/http.dart' as http;
import 'package:journal/utils/constants.dart';

String server = Constants.appServer;
class PointsSourceImpl extends PointsSource{

  @override
  Future<DataResponse<List<Point>>> getPointsList(String? accessToken) async {
    try {
      var url = Uri.parse('$server/v1/points');
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      });
      var jsonResponse = jsonDecode(response.body);
      var apiPointsList = ApiPointsList.fromJson(jsonResponse);

      return Future.delayed(
          const Duration(milliseconds: 200),
              () => DataResponse.success(List.generate(
              apiPointsList.apiPoints.length,
                  (index) =>
                  PointMapper.fromApi(apiPointsList.apiPoints[index]))));
    } catch (error) {
      return DataResponse.error(error.toString());
    }
  }

  @override
  void setApiPoint(String? accessToken, Point point) async {
    print('points: $accessToken');
    ApiPoint apiPoint = PointMapper.toApi(point);
    var url = Uri.parse('$server/v1/points/create');
    await http.post(
      url,
      body: jsonEncode(apiPoint.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );
  }
}