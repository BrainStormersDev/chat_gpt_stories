import 'dart:convert';

import 'package:chat_gpt_stories/controllers/get_token_controller.dart';
import 'package:chat_gpt_stories/utils/MyRepo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../common/headers.dart';
import '../../../model/text_completion_model.dart';
import '../model/GetStroyModels.dart';

class ChatTextController extends GetxController {
  //TODO: Implement ChatTextController

  @override
  void onInit() {
    print("========fff========");
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

  // List<TextCompletionData> messages = [TextCompletionData(
  //   text: '',
  //   index:2,
  //   finish_reason: '',
  // )];


  var state = ApiState.notFound.obs;
  Rx<GetStoryModels> getStoryModels =GetStoryModels(status: false,message: '',data: DataOfStory(story: '',images: [],storyNote: '',storyTitle: '')).obs;
  RxString errorMsg=''.obs;

  getTextCompletion({required String query}) async {


    print("=======query:${query}=========");
    // addMyMessage();

    state.value = ApiState.loading;

    try {
      // Map<String, String> rowParams = {
      //   "model": "text-curie-001",
      //   // "model": "text-davinci-003",
      //   "prompt": query,
      // };

      // final encodedParams = json.encode(rowParams);

      final response = await http.post(
        Uri.parse("${kBaseUrl}get-stories"),
        body: {
          "search": query,
        },

        // body: json.encode({
        //   "search": 'Princes',
        // }),



        // body: json.encode({
        //   "model": "text-davinci-003",
        //   "prompt": query,
        //   'temperature': 0,
        //   'max_tokens': 4000,
        //   'top_p': 1,
        //   'frequency_penalty': 0.0,
        //   'presence_penalty': 0.0,
        // }),
        // body: encodedParams,

        // headers: headerBearerOption(MyRepo.kApiToken.value),
      );
      print("Response $query  getTextCompletion====  ${response.body}");

      if (response.statusCode == 200) {
        // messages =
        //     TextCompletionModel.fromJson(json.decode(response.body)).choices;
        //
        // addServerMessage(
        //     TextCompletionModel.fromJson(json.decode(response.body)).choices);
        getStoryModels =GetStoryModels(status: false,message: '',data: DataOfStory(story: '',images: [])).obs;

        getStoryModels.value =GetStoryModels.fromJson(json.decode(response.body));
        print("Response $query  getTextCompletion====  ${response.body}");



        state.value = ApiState.success;
      } else {
        // throw ServerException(message: "Image Generation Server Exception");


     state.value = ApiState.error;
     errorMsg.value = "Error :${getStoryModels.value.message}";


      }
    } catch (e) {
      print("Errorrrrrrrrrrrrrrr  ");

      state.value = ApiState.error;
      errorMsg.value = "Error :$e";
    } finally {
      // searchTextController.clear();
      update();
    }
  }

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
