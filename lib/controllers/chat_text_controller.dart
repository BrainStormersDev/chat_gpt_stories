import 'dart:convert';

import '../../controllers/get_token_controller.dart';
import '../../model/storyCatListModel.dart';
import '../../utils/MyRepo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../common/headers.dart';
import '../../../model/text_completion_model.dart';
import '../model/GetStroyModels.dart';

class ChatTextController extends GetxController {
  RxString filter = ''.obs;
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
  var state = ApiState.notFound.obs;
  Rx<StoryCatListModel> storyCategoryListModels =StoryCatListModel(status: false,message: '',data: []).obs;
 RxString errorMsg=''.obs;
  void setFilter(String value) {
    filter.value = value.toLowerCase();
  }
  Object get filteredList {
    if (filter.value=="") {
      return storyCategoryListModels.value;
    } else {
      return storyCategoryListModels.value.data!.where((element) => element.storyTitle!.toString().toLowerCase().contains(filter.value)|| element.storyTitle.toString().toLowerCase().contains(filter.value)).toList();
    }
  }
  getTextCompletion({required String query, required String catId}) async {
    state.value = ApiState.loading;
    try {
      final response = await http.post(
        Uri.parse("${kBaseUrl}get-stories"),
        body: {
          "search": query,
          "cat_id": catId,
        }, );
      if (response.statusCode == 200) {
        storyCategoryListModels =StoryCatListModel(status: false,message: '',data: []).obs;
        storyCategoryListModels.value =StoryCatListModel.fromJson(json.decode(response.body));
// logger.e(storyCategoryListModels.value.data![0].images![0].imageUrl);
        state.value = ApiState.success;
      } else {
        logger.e(response.statusCode);
        state.value = ApiState.error;
        errorMsg.value = "Error :${storyCategoryListModels.value.message}";
      }
    } catch (e) {
      state.value = ApiState.error;
      errorMsg.value = "Error :$e";
    } finally {;
      update();
    }
  }
  // getTextCompletions({required String query}) async {
  //   state.value = ApiState.loading;
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${kBaseUrl}get-stories"),
  //       body: {
  //         "search": query,
  //       },
  //     );
  //
  //
  //     if (response.statusCode == 200) {
  //       // logger.i("Response $query  getTextCompletion====  ${response.body}");
  //       getStoryModels =GetStoryModels(status: false,message: '',data:[]).obs;
  //       getStoryModels.value =GetStoryModels.fromJson(json.decode(response.body));
  //       state.value = ApiState.success;
  //     } else {
  //       state.value = ApiState.error;
  //       errorMsg.value = "Error :${getStoryModels.value.message}";
  //     }
  //   } catch (e) {
  //     // logger.e("Errorrrrrrrrrrrrrrr  ");
  //
  //     state.value = ApiState.error;
  //     errorMsg.value = "Error :$e";
  //   } finally {
  //     // searchTextController.clear();
  //     update();
  //   }
  // }














  // addServerMessage(List<TextCompletionData> choices) {
  //   for (int i = 0; i < choices.length; i++) {
  //     messages.insert(i, choices[i]);
  //   }
  // }

  // addMyMessage() {
  //   // {"text":":\n\nWell, there are a few things that you can do to increase","index":0,"logprobs":null,"finish_reason":"length"}
  //   TextCompletionData text = TextCompletionData(
  //       text: searchTextController.text, index: -999999, finish_reason: "");
  //   messages.insert(0, text);
  // }

  TextEditingController searchTextController = TextEditingController();
}
