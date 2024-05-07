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
  Rx<StoryCatListModel> storyCategoryListModels =
      StoryCatListModel(status: false, message: '', data: []).obs;
  RxString errorMsg = ''.obs;
  var token;

  void setFilter(String value) {
    filter.value = value.toLowerCase();
  }

  Future<void> getMyStories() async {
    state.value = ApiState.loading;
    print("MyRepo.bearerToken :${GetStorage().read("bearerToken")}");
    if (GetStorage().read("bearerToken").toString().isNotEmpty) {
      token = GetStorage().read("bearerToken");
    }
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print(headers['Authorization']);
    try {
      await ApisCall.multiPartApiCall(
              "https://gptstory.thebrainstormers.org/api/v1/user/story/list",
              'get',
              {},
              header: headers)
          .then((value) {
        if (value["isData"]) {
          storyCategoryListModels.value =
              storyCatListModelFromJson(value["response"]);

          state.value = ApiState.success;
        } else {
          state.value = ApiState.error;
          errorMsg.value = value["message"];
        }
      });
    } catch (e) {
      errorMsg.value = "Something Went Wrong!";

      state.value = ApiState.error;
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
    storyCategoryListModels =
        StoryCatListModel(status: false, message: '', data: []).obs;
    try {
      ApisCall.apiCall(
              "${kBaseUrl}api/v1/get-stories",
              "post",
              {
                "search": query,
                "cat_id": catId,
              },
              isSnackBarShow: true)
          .then((value) {
        if (value["isData"]) {
          logger.i(value["message"]);
          state.value = ApiState.success;
          storyCategoryListModels =
              StoryCatListModel(status: false, message: '', data: []).obs;
          storyCategoryListModels.value =
              storyCatListModelFromJson(value["response"]);
        } else {
          logger.e(value["message"]);
          state.value = ApiState.error;
          errorMsg.value = value["message"];
        }
      });
    } catch (e) {
      logger.e("error: $e");
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

  /// get specific story by story id to read
  getStory({required String storyId}) async {
    state.value = ApiState.loading;
    try {
      print("story id: ${storyId}");

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
          // print("new story id: ${storyDetailModel.data!.story!.id.toString()}");

          state.value = ApiState.success;
          if (storyDetailModel.data != null &&
              storyDetailModel.data!.story != null) {
            CreateStoryController().isNewStory.value = false;
            Navigator.push(
                Get.context!,
                MaterialPageRoute(
                    builder: (context) => StoryViewPage(
                          story: storyDetailModel.data!.story!.story.toString(),
                          storyTitle: storyDetailModel.data!.story!.storyTitle!
                              .toString(),
                          images: storyDetailModel.data!.images,
                        )));
          } else {
            MySnackBar.snackBarRed(
                title: 'Sorry', message: 'Something went wrong!');
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
