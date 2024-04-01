import 'package:gpt_chat_stories/utils/apiCall.dart';

import '../../model/StoryCategoryModels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/headers.dart';
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
   Rx<StoryCategoryModels> storyCategoryModels =StoryCategoryModels(status: false,message: '',data: []).obs;
  RxString errorMsg=''.obs;

  var state = ApiState.notFound.obs;

   Future<void>getCat() async {
    state.value = ApiState.loading;
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    try {
      await ApisCall.multiPartApiCall("${kBaseUrl}api/v1/get-category", "get", {},
      header: headers
      ).then((value)
      {
        if(value["isData"])
          {
            storyCategoryModels.value =storyCategoryModelsFromJson(value["response"]);

            if (storyCategoryModels.value.status!) {
              print("storyCategoryModels: ${storyCategoryModels.value.data!.length},${storyCategoryModels.value.message}=========");


              if(storyCategoryModels.value.data!.isEmpty) {
                state.value = ApiState.notFound;
              }
              else
                state.value = ApiState.success;
            }
            else {
              print("error in getting categories (status false): ${storyCategoryModels.value.message}");
              state.value = ApiState.error;
            }
          }
      });
    } catch (e) {
      state.value = ApiState.error;
      errorMsg.value = "Error :$e";
      print("=====Error story category $e====");

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
