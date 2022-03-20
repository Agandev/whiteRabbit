import 'dart:io' show Directory;

import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const _databaseName = "AppDatabase.db";
  static const _databaseVersion = 1;

  final employeeDetailsTable = 'employee_details';

  final employeeTableId = 'address_table_id';
  final employeeId = 'employee_id';
  final employeeName = 'employee_name';
  final employeeUsername = 'employee_username';
  final employeeEmail = 'employee_email';
  final employeeProfileImage = 'employee_profile_image';
  final employeeAddressStreet = 'street';
  final employeeAddressSuite = 'suite';
  final employeeAddressCity = 'city';
  final addressZipcode = 'zipcode';
  final employeeAddressGeoLlt = 'lat';
  final employeeAddressGeoLng = 'lng';
  final employeePhone = 'phone';
  final employeeWebsite = 'website';
  final employeeCompanyName = 'company_name';
  final employeeCompanyCatchPhrase = 'company_catch_phrase';
  final employeeCompanyBs = 'company_bs';

  DatabaseService._privateConstructor();

  static final DatabaseService instance = DatabaseService._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // _initDatabase();
    await db.execute('''
          CREATE TABLE  IF NOT EXISTS $employeeDetailsTable (
           id  INTEGER PRIMARY KEY AUTOINCREMENT,
            $employeeId INTEGER,
            $employeeName TEXT,
            $employeeUsername TEXT,
            $employeeEmail TEXT,
            $employeePhone TEXT,
            $employeeProfileImage TEXT,
            $employeeAddressStreet TEXT,
            $employeeAddressSuite TEXT,
            $employeeAddressCity TEXT,
            $addressZipcode TEXT,
            $employeeAddressGeoLlt REAL,
            $employeeAddressGeoLng REAL,
            $employeeWebsite TEXT,
             $employeeCompanyName TEXT,
              $employeeCompanyCatchPhrase TEXT,
               $employeeCompanyBs TEXT
          )
          ''');
  }
}
