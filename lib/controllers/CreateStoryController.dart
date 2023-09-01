import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../common/headers.dart';
import '../../../model/text_completion_model.dart';
import '../model/openAiResponseModel.dart';
import '../model/storyCatListModel.dart';
import '../utils/MyRepo.dart';
import '../view/Pages/story_page.dart';

class CreateStoryController extends GetxController {
  //TODO: Implement ChatTextController
  // RxList<OpenAiResponse> openAiResponse =<OpenAiResponse>[].obs;
  RxString openAiResponse =''.obs;
  RxBool isLoading=false.obs;
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

  // getTextCompletion(String query) async {
  //   addMyMessage();
  //
  //   state.value = ApiState.loading;
  //   try {
  //     Map<String, dynamic> rowParams = {
  //       "model": "text-davinci-003",
  //       "prompt": query,
  //       'max_tokens': 1000,
  //       // 'max_tokens': 200,
  //       'temperature': 0.5,
  //       'top_p': 1.0,
  //       'n': 1,
  //       // 'stop': '\n',
  //
  //     };
  //
  //     final encodedParams = json.encode(rowParams);
  //     print("======== encodedParams :$encodedParams");
  //     final response = await http.post(
  //       Uri.parse(endPoint("completions")),
  //       body: encodedParams,
  //       headers: headerBearerOption("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"),
  //     );
  //     print("Response  body  ${response.body}");
  //     print("Response  status  ${response.statusCode}");
  //     if (response.statusCode == 200) {
  //       // messages =
  //       //     TextCompletionModel.fromJson(json.decode(response.body)).choices;
  //       //
  //       addServerMessage(
  //           TextCompletionModel.fromJson(json.decode(response.body)).choices);
  //       state.value = ApiState.success;
  //     } else {
  //       // throw ServerException(message: "Image Generation Server Exception");
  //       state.value = ApiState.error;
  //     }
  //   } catch (e) {
  //     print("Errorrrrrrrrrrrrrrr ");
  //   } finally {
  //     // searchTextController.clear();
  //     update();
  //   }
  // }
  //
  // addServerMessage(List<TextCompletionData> choices) {
  //   for (int i = 0; i < choices.length; i++) {
  //     messages.insert(i, choices[i]);
  //   }
  // }
  //
  // addMyMessage() {
  //   // {"text":":\n\nWell, there are a few things that you can do to increase","index":0,"logprobs":null,"finish_reason":"length"}
  //   TextCompletionData text = TextCompletionData(
  //       text: searchTextController.text, index: -999999, finish_reason: "");
  //   messages.insert(0, text);
  // }
  //
  TextEditingController searchTextController = TextEditingController();


storyCreateCall(String storyTitle,int id) async {
  // state.value = ApiState.loading;
  isLoading.value=true;
  print("======== 1 ${isLoading.value}");
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${GetStorage().read("bearerToken")}'};
  var request = http.MultipartRequest('POST', Uri.parse('http://story-telling.eduverse.uk/api/v1/user/story/create'));
  request.fields.addAll({
    'cat_id': "$id",
    'story_title': storyTitle
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // print(await response.stream.bytesToString());
    var res=await response.stream.bytesToString();
    print("========= response $res");
    state.value = ApiState.success;
    isLoading.value=false;
   MyRepo.isSelectedMyStory.value=true;
    searchTextController.clear();
    var storyData=   StoryCatListModel.fromJson(json.decode(res.toString()));
    // Rx<DataList> dataList=storyData.data as Rx<DataList>;
    print("===========data ${storyData.data}");
    Get.to(()=>StoryPage(data: storyData.data!.first ) );
    print("======== 2 ${isLoading.value}");
  }
  else {
    isLoading.value=false;
    print("======== 3 ${isLoading.value}");
    state.value = ApiState.error;

    print(response.reasonPhrase);
  }

}




}
