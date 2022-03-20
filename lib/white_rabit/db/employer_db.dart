import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:white_rabit_employer_detials/white_rabit/db/db_service.dart';
import 'package:white_rabit_employer_detials/white_rabit/screens/landing/employee_model.dart';

class EmployerDatabase {
  final DatabaseService _service;

  EmployerDatabase(this._service);


  Future<dynamic> addEmployeeDetails(EmployerDetails employeeDetails) async {
    try{
      final Database? db = await _service.database;

      return await db!.insert(
        _service.employeeDetailsTable,
        employeeDetails.toJson(),
      );


    } on DatabaseException catch (e){


    }

  }

  Future<List<EmployerDetails>>  fetchAddresses() async {

    final Database? db = await _service.database;
    List<EmployerDetails>  employeeDetails=[];

    final List<Map<String, dynamic>> maps = await db!.rawQuery(
        'SELECT * FROM ${_service.employeeDetailsTable} ');

    maps.forEach((v) {
      employeeDetails.add( EmployerDetails.fromJsonDB(v));
    });


    return employeeDetails;



  }




}
