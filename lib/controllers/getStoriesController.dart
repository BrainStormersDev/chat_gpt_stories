import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:gpt_chat_stories/model/storyDetailModel.dart';
import 'package:gpt_chat_stories/utils/apiCall.dart';
import 'package:gpt_chat_stories/utils/mySnackBar.dart';

import '../../model/storyCatListModel.dart';
import '../../utils/MyRepo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../common/headers.dart';
import '../view/Pages/story_view_page.dart';
import 'CreateStoryController.dart';

class StoriesController extends GetxController {
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
  Rx<StoryCatListModel> storyCategoryListModels = StoryCatListModel(status: false, message: '', data: []).obs;
  RxString errorMsg = ''.obs;
  var token;

  void setFilter(String value) {
    filter.value = value.toLowerCase();
  }
  Future<void> getMyStories() async {
    state.value=ApiState.loading;
    print("========= MyRepo.bearerToken :${GetStorage().read("bearerToken")}");
    if (GetStorage().read("bearerToken").toString().isNotEmpty) {
      token = GetStorage().read("bearerToken");
    }
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      await ApisCall.multiPartApiCall(
          "http://gptstory.thebrainstormers.org/api/v1/user/story/list",
          'get',
          {},
          header: headers)
          .then((value) {
        if (value["isData"]) {
          storyCategoryListModels.value=storyCatListModelFromJson(value["response"]);
          state.value=ApiState.success;
        } else {
          state.value=ApiState.error;

        }
      });
    } catch (e) {
      state.value=ApiState.error;
      print(e);
    }
  }

  Object get filteredList {
    if (filter.value == "") {
      return storyCategoryListModels.value;
    } else {
      return storyCategoryListModels.value.data!
          .where((element) =>
              element.storyTitle!
                  .toString()
                  .toLowerCase()
                  .contains(filter.value) ||
              element.storyTitle
                  .toString()
                  .toLowerCase()
                  .contains(filter.value))
          .toList();
    }
  }

  getTextCompletion({required String query, required String catId}) async {
    state.value = ApiState.loading;
    try {
      final response = await http.post(
        Uri.parse("${kBaseUrl}api/v1/get-stories"),
        body: {
          "search": query,
          "cat_id": catId,
        },
      );
      if (response.statusCode == 200) {
        storyCategoryListModels =
            StoryCatListModel(status: false, message: '', data: []).obs;
        storyCategoryListModels.value =
            StoryCatListModel.fromJson(json.decode(response.body));

        state.value = ApiState.success;
      } else {
        logger.e(response.statusCode);
        state.value = ApiState.error;
        errorMsg.value = "Error :${storyCategoryListModels.value.message}";
      }
    } catch (e) {
      state.value = ApiState.error;
      errorMsg.value = "Error :$e";
    } finally {
      ;
      update();
    }
  }

  TextEditingController searchTextController = TextEditingController();
  StoryDetailModel storyDetailModel = StoryDetailModel();
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };

  getStory({required String storyId}) async {
    state.value = ApiState.loading;
    try {
      await ApisCall.multiPartApiCall(
              "${kBaseUrl}api/v1/get-story",
              'post',
              {
                "story_id": storyId,
              },
              header: headers)
          .then((value) {
        if (value["isData"]) {
          storyDetailModel = storyDetailModelFromJson(value["response"]);
          print(
              "story title: ${storyDetailModel.data!.story!.storyTitle!.toString()}");
          state.value = ApiState.success;
          if(storyDetailModel.data!=null && storyDetailModel.data!.story!=null)
            {

              CreateStoryController().isNewStory.value=false;

              Navigator.push(
                  Get.context!,
                  MaterialPageRoute(
                      builder: (context) => StoryViewPage(
                        story:storyDetailModel.data!.story!.story.toString(),
                        storyTitle: storyDetailModel.data!.story!.storyTitle!.toString(),
                        images: storyDetailModel.data!.images,
                      )));
            }
          else
            {
              MySnackBar.snackBarRed(title: 'Sorry', message: 'Something went wrong!');
            }

        } else {
          logger.e("Error in getting single story");
        }
      });
    } catch (e) {
      logger.e("Error in getting single story is $e");
      state.value = ApiState.error;
      errorMsg.value = "Error :$e";
    } finally {
      update();
    }
  }
}
