import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../../../common/headers.dart';
import 'package:http/http.dart' as http;
import '../model/StoryCategoryModels.dart';
import '../utils/MyRepo.dart';

class StoryCatController extends GetxController {
  //TODO: Implement ChatImageController

  @override
  void onInit() {

    getCat();
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

  // List<ImageGenerationData> images = [];

   Rx<StoryCategoryModels> storyCategoryModels =StoryCategoryModels(status: false,message: '',data: []).obs;
  RxString errorMsg=''.obs;

  var state = ApiState.notFound.obs;

  getCat() async {
    state.value = ApiState.loading;
    // images.clear();

    try {
      final response = await http.get(
        Uri.parse("${kBaseUrl}get-category"),
        // body: encodedParams,
        // headers: headerBearerOption(MyRepo.kApiToken.value),
      );
      storyCategoryModels.value = StoryCategoryModels.fromJson(json.decode(response.body));
      if (storyCategoryModels.value.status!) {
        print("=====storyCategoryModels: ${storyCategoryModels.value.data!.length},${storyCategoryModels.value.message}=========");
        if(storyCategoryModels.value.data!.isEmpty) {
          state.value = ApiState.notFound;
        }
        else {
          state.value = ApiState.success;
        }
      }

      else {
        print("=====fffff====");
        state.value = ApiState.error;
      }
    } catch (e) {
      state.value = ApiState.error;
      errorMsg.value = "Error :$e";
      print("=====Errorrrrrrrrrrrrrrr$e====");
      // print("Errorrrrrrrrrrrrrrr  ");
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
