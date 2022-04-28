import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:food_delivery/utils/app_constants.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late SharedPreferences sharedPreferences;

  ApiClient({
    required this.appBaseUrl,
    required this.sharedPreferences,
  }) {
    baseUrl = appBaseUrl;
    token = sharedPreferences.getString(AppConstants.token)??AppConstants.token;

    timeout = Duration(seconds: 30);
    _mainHeaders = {
      'Content-type': 'Application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

  void updateHeaders(String token) {
    _mainHeaders = {
      'Content-type': 'Application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      Response response = await get(uri, headers: headers ?? _mainHeaders);
      return response;
    } catch (e) {
      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    try {
      Response response = await post(uri, body, headers: _mainHeaders);

      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
