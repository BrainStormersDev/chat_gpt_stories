import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../common/headers.dart';
import '../../../model/text_completion_model.dart';
import '../model/new_story_create_model.dart';
import '../utils/MyRepo.dart';

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

  // List<Message> messages = [];
  List<Choice> messageChoice = [];

  var state = ApiState.notFound.obs;
  Message? messageData= Message();
  getTextCompletion(String query) async {
    addMyMessage();

    state.value = ApiState.loading;
    try {
    //   Map<String, dynamic> rowParams = {
    //     "model": "gpt-3.5-turbo",
    //   "messages": [
    // {
    // "role": "user",
    // "content": query
    // }
    // ],
    //     // 'max_tokens': 1000,
    //     // 'max_tokens': 200,
    //     // 'temperature': 0.5,
    //     // 'top_p': 1.0,
    //     // 'n': 1,
    //     // 'stop': '\n',
    //
    //   };

      // final encodedParams = json.encode(rowParams);
      // print("======== encodedParams :$encodedParams");
      // http.Request('POST', Uri.parse('https://api.openai.com/v1/chat/completions'));
      // request.body = json.encode({
      //   "model": "gpt-3.5-turbo",
      //   "messages": [
      //     {
      //       "role": "user",
      //       "content": "Thirsty crow story"
      //     }
      //   ]
      // });
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        body: json.encode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content": searchTextController.text
            }
          ]
        }),
        headers: headerBearerOption("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"),
      );

      if (response.statusCode == 200) {
        // logger.i("Response  body  ${response.body}");
        // logger.f("Response  body  ${(json.decode(response.body)["choices"])}");
        var textCompilation= textCompletionModelFromJson(response.body);
        if(textCompilation.choices!=null)
          {
            addServerMessage(
                textCompilation.choices
            );
          }
        state.value = ApiState.success;
      }
      else {
        state.value = ApiState.error;
      }
    }
    catch (e) {
      // logger.e("Errorrrrrrrrrrrrrrr ");
    } finally {
      // searchTextController.clear();
      update();
    }
  }
 ///
  ///



  List<StoryData> allStoryData = [];
  List<String?> storyTitle = [];
  CreateStory storyCreateResponse = CreateStory();
  String? story= '';
  createStory(String title) async {
    storyTitle.add(searchTextController.text);
    addMyStory();

    state.value = ApiState.loading;
    // print("========= MyRepo.bearerToken :${GetStorage().read("bearerToken")}");

    try {var headers = {
     'Accept': 'application/json',
     'Content-Type': 'application/json',
     'Authorization': 'Bearer ${GetStorage().read("bearerToken")}' };
   var request = http.MultipartRequest('POST', Uri.parse('http://story-telling.eduverse.uk/api/v1/user/story/create'));
   request.fields.addAll({
     'cat_id': '14',
     'story_title': title
   });

   request.headers.addAll(headers);

   http.StreamedResponse response = await request.send();

   if (response.statusCode == 200) {
     var body=await response.stream.bytesToString();
     storyCreateResponse= createStoryFromJson(body);
     if(storyCreateResponse.data!=null)
     {
       addStoryMessages(
           storyCreateResponse.data
       );
       logger.i(body);
       state.value = ApiState.success;
     }
     else
     {state.value = ApiState.error;}
   }
   else {
     state.value = ApiState.error;
     logger.e(response.reasonPhrase);
   }}
    catch (e) {
      logger.e("Error $e");
    } finally {
      // searchTextController.clear();
      update();
    }
  }


  addStoryMessages(List<StoryData>? storyData) {
    for (int i = 0; i < storyData!.length; i++) {
      allStoryData.insert(i, storyData[i]);
      // logger.i(messageChoice[i].message);
      story=allStoryData[i].story;
      storyTitle.insert(i,allStoryData[i].storyTitle);

    }
  }
  addServerMessage(List<Choice>? choices) {
    for (int i = 0; i < choices!.length; i++) {
      messageChoice.insert(i, choices[i]);
      // logger.i(messageChoice[i].message);
      messageData=messageChoice[i].message;
    }

  }



  TextEditingController searchTextController = TextEditingController();

  addMyMessage() {
    // {"text":":\n\nWell, there are a few things that you can do to increase","index":0,"logprobs":null,"finish_reason":"length"}
    Choice text = Choice( message: messageData, index: -999999, finishReason: "");
    messageChoice.insert(0, text);
  }
  addMyStory() {
    // {"text":":\n\nWell, there are a few things that you can do to increase","index":0,"logprobs":null,"finish_reason":"length"}
    // CreateStory text = CreateStory( status: false, message:'', data: allStoryData);
    allStoryData.insert(0,StoryData());
  }


}
