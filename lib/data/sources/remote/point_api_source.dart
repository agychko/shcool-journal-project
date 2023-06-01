
import 'dart:convert';

import 'package:journal/domain/entities/point.dart';
import 'package:http/http.dart' as http;
import 'package:journal/utils/constants.dart';
import '../../models/mapper/point_mapper.dart';
import '../../models/response/data_response.dart';
import '../../models/remote/api_point.dart';
import '../local/preferences_source.dart';

String server = Constants.appServer;
class PointApiSource {
  final PreferencesSource preferencesSource = PreferencesSource();
  Future<DataResponse<List<Point>>> getPointsList() async {
    try {
      var url = Uri.parse('$server/v1/points');
      String? accessToken = await preferencesSource.getAccessToken();
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

  void setApiPoint(Point point) async {
    ApiPoint apiPoint = PointMapper.toApi(point);
    var url = Uri.parse('$server/v1/points/create');
    String? accessToken = await preferencesSource.getAccessToken();
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