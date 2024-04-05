import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gpt_chat_stories/utils/apiCall.dart';
import 'package:gpt_chat_stories/utils/mySnackBar.dart';
import 'package:http/http.dart' as http;
import '../../../common/headers.dart';
import '../../../model/text_completion_model.dart';
import '../model/newStoryCreated.dart';
import '../model/new_story_create_model.dart';
import '../model/storyCatListModel.dart';
import '../utils/MyRepo.dart';
import '../view/Pages/rate_us_page.dart';
import '../view/Pages/story_view_page.dart';

class CreateStoryController extends GetxController {
  //TODO: Implement ChatTextController

  @override
  void onInit() {
    print("Create Story Controller");
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

  List<Choice> messageChoice = [];
  RxBool isNewStory = false.obs;
  var state = ApiState.notFound.obs;
  Message? messageData = Message();

  // getTextCompletion(String query) async {
  //   addMyMessage();
  //
  //   state.value = ApiState.loading;
  //   try {
  //     ApisCall.apiCall('https://api.openai.com/v1/chat/completions', "post", {
  //       "model": "gpt-3.5-turbo",
  //       "messages": [
  //         {"role": "user", "content": searchTextController.text}
  //       ]
  //     }, header:GetStorage().read("bearerToken" )).then((value) {
  //
  //
  //       if(value["isData"])
  //         {
  //           var textCompilation = textCompletionModelFromJson(value["response"]);
  //           if (textCompilation.choices != null) {
  //             addServerMessage(textCompilation.choices);
  //             state.value = ApiState.success;
  //
  //           }
  //         }
  //
  //       else
  //       {
  //       state.value = ApiState.error;
  //       }
  //
  //
  //
  //     });
  //   } catch (e) {
  //     // logger.e("Errorrrrrrrrrrrrrrr ");
  //   } finally {
  //     // searchTextController.clear();
  //     update();
  //   }
  // }

  ///
  ///

  String? selectedCategory;
  String? selectedCategoryId;

  // List<StoryData> allStoryData = [];
  List<String?> storyTitle = [];

  // CreateStory storyCreateResponse = CreateStory();
  NewStoryCreatedModel? newStoryCreatedResponse;

  String? story = '';

  Future<void> createStory() async {
    print("base url is ${kBaseUrl}");
    state.value = ApiState.loading;
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read("bearerToken")}'
      };

      ApisCall.multiPartApiCall(
              "${kBaseUrl}api/v1/user/story/fetch",
              "post",
              {
                'cat_id': selectedCategoryId!,
                'story_title': searchTextController.text
              },
              header: headers)
          .then((value) {
        if (value["isData"]) {
          newStoryCreatedResponse =
              newStoryCreatedModelFromJson(value['response']);

          state.value = ApiState.success;
          if (newStoryCreatedResponse != null &&
              newStoryCreatedResponse!.data != null) {
            isNewStory = true.obs;
            Navigator.push(
                Get.context!,
                MaterialPageRoute(
                    builder: (context) => StoryViewPage(
                        isNewStory:isNewStory.value,
                          story:
                              newStoryCreatedResponse!.data!.story.toString(),
                          storyTitle:
                              newStoryCreatedResponse!.data!.title.toString(),
                          images: newStoryCreatedResponse!.data!.images,
                        )));
          } else {
            MySnackBar.snackBarRed(
                title: 'Sorry', message: 'Something went wrong!');
          }
        } else {
          state.value = ApiState.error;
        }
      });
    } catch (e) {
      logger.e("Error $e");
      state.value = ApiState.error;
    } finally {
      // searchTextController.clear();
      update();
    }
  }

  Future<void> saveStory() async {
    print("base url is ${kBaseUrl}");
    state.value = ApiState.loading;
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read("bearerToken")}'
      };

      await ApisCall.multiPartApiCall(
              "${kBaseUrl}api/v1/user/story/save",
              "post",
              {
                'cat_id': selectedCategoryId!,
                // 'title': "ioioio",
                'title': newStoryCreatedResponse!.data!.title.toString(),
                // 'story': "nmnkjkjkjkji  kjkjkjkjkj"
                'story': newStoryCreatedResponse!.data!.story.toString()
              },
              header: headers)
          .then((value) {
        if (value["isData"]) {
          state.value = ApiState.success;
          print(jsonDecode(value["response"])["data"]["story_id"]);

          MyRepo.currentStory.value.id = int.parse(
              jsonDecode(value["response"])["data"]["story_id"].toString());
          Navigator.push(Get.context!,
              MaterialPageRoute(builder: (context) => RateUsPage()));
        } else {
          print("response");
          print(jsonDecode(value["response"]));

          MySnackBar.snackBarYellow(title: 'Oh!', message: value["message"]);

          state.value = ApiState.error;
        }
      });
    } catch (e) {
      logger.e("Error $e");
      state.value = ApiState.error;
    } finally {
      // searchTextController.clear();
      update();
    }
  }

  addServerMessage(List<Choice>? choices) {
    for (int i = 0; i < choices!.length; i++) {
      messageChoice.insert(i, choices[i]);

      messageData = messageChoice[i].message;
    }
  }

  TextEditingController searchTextController = TextEditingController();

  addMyMessage() {
    // {"text":":\n\nWell, there are a few things that you can do to increase","index":0,"logprobs":null,"finish_reason":"length"}
    Choice text =
        Choice(message: messageData, index: -999999, finishReason: "");
    messageChoice.insert(0, text);
  }
}
