import 'package:gpt_chat_stories/utils/apiCall.dart';

import '../../utils/MyRepo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../../../common/headers.dart';
import 'package:http/http.dart' as http;

import '../model/RegistrationModels.dart';

class RegistrationController extends GetxController {
  //TODO: Implement ChatImageController

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  late RegistrationModels registrationModels;
  var state = ApiState.notFound.obs;

  getRegistration({required String age, String? token,required String gender}) async {

    print("age: $age");
    print("token: $token");
    print("gender: $gender");

    state.value = ApiState.loading;
    registrationModels =RegistrationModels(status: false,message: '',data:Data());

    try {
      Map<String, dynamic> rowParams = {
        "age": age,
        "device_token":token,
        "gender":gender,
        "name":'',
        "email": '',
      };

ApisCall.apiCall("${kBaseUrl}register", "post", rowParams).then((value) {

  if(value["isData"]){

    registrationModels = RegistrationModels.fromJson(value["response"]);
    print("success ");
    state.value = ApiState.success;
  }
  else
    {
      print("Error ${value["message"]} registration_controller");
      state.value = ApiState.error;
    }
});

    } catch (e) {
      print("Error $e");
    } finally {
      update();
    }
  }

  TextEditingController searchTextController = TextEditingController();

  clearTextField() {
    searchTextController.clear();
  }
}
