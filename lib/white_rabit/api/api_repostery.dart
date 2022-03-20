import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:white_rabit_employer_detials/white_rabit/api/api_path.dart';
import 'package:white_rabit_employer_detials/white_rabit/api/api_services.dart';
import 'package:white_rabit_employer_detials/white_rabit/screens/landing/employee_model.dart';

class ApiRepository {
  Future fetchEmployerDetails() async {
    RestAPIService restAPIService = RestAPIService(Dio());
    var employees = await restAPIService.getService(
      url: WhiteRabbitEmployeeDetailsAPI.employeeDetails, );
    return employees;
  }

}