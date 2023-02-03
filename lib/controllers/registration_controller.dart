import 'package:chat_gpt_stories/utils/MyRepo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../../../common/headers.dart';
import '../../../model/image_generation_model.dart';
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

    print("=======age: $age=======");
    print("=======token: $token=======");
    print("=======gender: $gender=======");

    state.value = ApiState.loading;
    registrationModels =RegistrationModels(status: false,message: '',data:Data());

    try {
      // ['256x256', '512x512', '1024x1024']
      Map<String, dynamic> rowParams = {
        "age": age,
        "device_token":token,
        "gender":gender,
        "name":'',
        "email": '',
      };

      // final encodedParams = json.encode(rowParams);

      final response = await http.post(
        Uri.parse("${kBaseUrl}register"),
        body: rowParams,
      );

      if (response.statusCode == 200) {
        registrationModels = RegistrationModels.fromJson(jsonDecode(response.body));
        print("succccccccccccccccccccccccc ");
        state.value = ApiState.success;
      } else {
        print("Errorrrrrrrrrrrrrrr  ${response.body}");
        // throw ServerException(message: "Image Generation Server Exception");
        state.value = ApiState.error;
      }
    } catch (e) {
      print("Errorrrrrrrrrrrrrrr  ");
    } finally {
     // searchTextController.clear();
      update();
    }
  }

  TextEditingController searchTextController = TextEditingController();

  clearTextField() {
    searchTextController.clear();
  }
}
