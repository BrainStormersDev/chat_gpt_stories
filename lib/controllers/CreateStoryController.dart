import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../common/headers.dart';
import '../../../model/text_completion_model.dart';

class CreateStoryController extends GetxController {
  //TODO: Implement ChatTextController

  @override
  void onInit() {

    print("=======ffff==========");
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

  List<TextCompletionData> messages = [];

  var state = ApiState.notFound.obs;

  getTextCompletion(String query) async {
    addMyMessage();

    state.value = ApiState.loading;
    try {
      Map<String, dynamic> rowParams = {
        "model": "text-davinci-003",
        "prompt": query,
        'max_tokens': 1000,
        // 'max_tokens': 200,
        'temperature': 0.5,
        'top_p': 1.0,
        'n': 1,
        // 'stop': '\n',

      };

      final encodedParams = json.encode(rowParams);
      print("======== encodedParams :$encodedParams");
      final response = await http.post(
        Uri.parse(endPoint("completions")),
        body: encodedParams,
        headers: headerBearerOption("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"),
      );
      print("Response  body  ${response.body}");
      print("Response  status  ${response.statusCode}");
      if (response.statusCode == 200) {
        // messages =
        //     TextCompletionModel.fromJson(json.decode(response.body)).choices;
        //
        addServerMessage(
            TextCompletionModel.fromJson(json.decode(response.body)).choices);
        state.value = ApiState.success;
      } else {
        // throw ServerException(message: "Image Generation Server Exception");
        state.value = ApiState.error;
      }
    } catch (e) {
      print("Errorrrrrrrrrrrrrrr ");
    } finally {
      // searchTextController.clear();
      update();
    }
  }

  addServerMessage(List<TextCompletionData> choices) {
    for (int i = 0; i < choices.length; i++) {
      messages.insert(i, choices[i]);
    }
  }

  addMyMessage() {
    // {"text":":\n\nWell, there are a few things that you can do to increase","index":0,"logprobs":null,"finish_reason":"length"}
    TextCompletionData text = TextCompletionData(
        text: searchTextController.text, index: -999999, finish_reason: "");
    messages.insert(0, text);
  }

  TextEditingController searchTextController = TextEditingController();
}
