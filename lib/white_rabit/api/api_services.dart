
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:white_rabit_employer_detials/white_rabit/api/api_exceptions.dart';
import 'package:white_rabit_employer_detials/white_rabit/api/api_path.dart';

class RestAPIService {
  final Dio _dio;

  RestAPIService(this._dio);


  getService({required String url}) async {

    String fetchUrl;
    try {
      // await getHeaders(useToken);

      if (url.contains("http")) {
        fetchUrl = url;
      } else {
        fetchUrl = WhiteRabbitEmployeeDetailsAPI.employeeDetails;
      }

      //debugPrint("HEADERS ====>>>>>>" + _dio.options.headers.toString());
      var response = await _dio.get(fetchUrl);
      debugPrint("URL ====>>>>>> GET : " + fetchUrl);
      debugPrint("RESPONSE ====>>>>>>" + response.data.toString());

      return response.data;
    } on DioError catch (dioError) {
      debugPrint(dioError.message);


      throw RestAPIException.fromDioError(dioError);
    }
  }

}
