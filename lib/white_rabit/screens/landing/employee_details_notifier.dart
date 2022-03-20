import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:white_rabit_employer_detials/white_rabit/api/api_repostery.dart';
import 'package:white_rabit_employer_detials/white_rabit/db/db_service.dart';
import 'package:white_rabit_employer_detials/white_rabit/screens/landing/employee_model.dart';
import 'package:white_rabit_employer_detials/white_rabit/db/employer_db.dart';
import 'package:white_rabit_employer_detials/white_rabit/api/response_state2.dart';



class EmployerNotifier extends StateNotifier<ResponseState2> {
  final ApiRepository _apiRepository;

  EmployerNotifier(this._apiRepository) : super(ResponseState2.initial());
  EmployerDatabase employerDatabase =
  EmployerDatabase(DatabaseService.instance);
  // String addressType;
  // var flatNo;
  // var streetName;
  // var landmark;

  EmployerDatabase addressDatabase =
  EmployerDatabase(DatabaseService.instance);

  Future<void> getAddresses({bool init = true}) async {
    try {
      if (init) state = state.copyWith(isLoading: true);

 ;
      List<EmployerDetails>? list = await addressDatabase.fetchAddresses();


      final employer;
      if (list.isEmpty) {
saveAddress();
        // employer = await _api.epository.fetchEmployerDetails();
      }
      else {
        employer = list;
      }


      // addressType =address.responseData.first.addressType;
      // flatNo = address.responseData.first.flatNo;
      // streetName = address.responseData.first.street;

      state =
          state.copyWith(response: list, isLoading: false, isError: false);
    } catch (e) {
      print(e.toString());
      state = state.copyWith(
          errorMessage: e.toString(), isError: true, isLoading: false);
    }
  }



  saveAddress(
      {bool init = true}) async {
    try {
      if (init) state = state.copyWith(isLoading: true);
      final fetchAddress = await _apiRepository.fetchEmployerDetails();

      for(int i=0;i<fetchAddress.length;i++) {
        EmployerDetails addressList = EmployerDetails.fromJson(
            fetchAddress[i]);

        employerDatabase.addEmployeeDetails(EmployerDetails(
          address: addressList.address,
          company: addressList.company,
          email: addressList.email,
          id: addressList.id,
          name: addressList.name,
          phone: addressList.phone,
          profileImage: addressList.profileImage,
          username: addressList.username,
          website: addressList.website,
        ));
      }

      List<EmployerDetails>? list = await employerDatabase.fetchAddresses();
      state =
          state.copyWith(response: list, isLoading: false, isError: false);


    }
    catch (e) {

      state = state.copyWith(
          errorMessage: e.toString(), isError: true, isLoading: false);
    }

  }




}