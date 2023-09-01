import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../common/headers.dart';
import '../model/storyCatListModel.dart';

class MyCreatedStoryController extends GetxController {
  //TODO: Implement ChatTextController
  // RxList<DataList> product = <DataList>[].obs;
  RxString filter = ''.obs;
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
  Rx<StoryCatListModel> storyCategoryListModels =StoryCatListModel(status: false,message: '',data: []).obs;
  Rx<StoryCatListModel> myCreatedStoryList =StoryCatListModel(status: false,message: '',data: []).obs;






  // Rx<GetStoryModels> getStoryModels =GetStoryModels(status: false,message: '',data: DataOfStory(story: '',images: [],storyNote: '',storyTitle: '')).obs;
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

  //
  // getTextCompletion({required String query, required String catId}) async {
  //
  //
  //   print("=======query:${query}=========");
  //   // addMyMessage();
  //
  //   state.value = ApiState.loading;
  //
  //
  //
  //
  //
  //
  //
  //
  //   ///
  //
  //   ///
  //   try {
  //     // Map<String, String> rowParams = {
  //     //   "model": "text-curie-001",
  //     //   // "model": "text-davinci-003",
  //     //   "prompt": query,
  //     // };
  //
  //     // final encodedParams = json.encode(rowParams);
  //
  //     final response = await http.post(
  //       Uri.parse("${kBaseUrl}get-stories"),
  //       body: {
  //         "search": query,
  //         "cat_id": catId,
  //       },
  //
  //       // body: json.encode({
  //       //   "search": 'Princes',
  //       // }),
  //
  //
  //
  //       // body: json.encode({
  //       //   "model": "text-davinci-003",
  //       //   "prompt": query,
  //       //   'temperature': 0,
  //       //   'max_tokens': 4000,
  //       //   'top_p': 1,
  //       //   'frequency_penalty': 0.0,
  //       //   'presence_penalty': 0.0,
  //       // }),
  //       // body: encodedParams,
  //
  //       // headers: headerBearerOption(MyRepo.kApiToken.value),
  //     );
  //     print("Response $query  getTextCompletion====  ${response.body}");
  //
  //     if (response.statusCode == 200) {
  //       // messages =
  //       //     TextCompletionModel.fromJson(json.decode(response.body)).choices;
  //       //
  //       // addServerMessage(
  //       //     TextCompletionModel.fromJson(json.decode(response.body)).choices);
  //       storyCategoryListModels =StoryCatListModel(status: false,message: '',data: []).obs;
  //       // getStoryModels =GetStoryModels(status: false,message: '',data: DataOfStory(story: '',images: [])).obs;
  //
  //       storyCategoryListModels.value =StoryCatListModel.fromJson(json.decode(response.body));
  //       // getStoryModels.value =GetStoryModels.fromJson(json.decode(response.body));
  //       print("Response $query  getTextCompletion====  ${response.body}");
  //       state.value = ApiState.success;
  //     } else {
  //
  //
  //       state.value = ApiState.error;
  //       errorMsg.value = "Error :${storyCategoryListModels.value.message}";
  //
  //
  //     }
  //   } catch (e) {
  //     print("Errorrrrrrrrrrrrrrr  ");
  //
  //     state.value = ApiState.error;
  //     errorMsg.value = "Error :$e";
  //   } finally {
  //     // searchTextController.clear();
  //     update();
  //   }
  // }


  myCreatedStoryListFun() async {
    var token;


    if(GetStorage().read("bearerToken").toString().isNotEmpty){
      token = GetStorage().read("bearerToken");
    }
    print("=== token $token");
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('GET', Uri.parse('http://story-telling.eduverse.uk/api/v1/user/story/list'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("====================================");
      // print(await response.stream.bytesToString());
      print("====================================");
      var res= await response.stream.bytesToString();
      // Future.delayed(const Duration(milliseconds: 200),() async {
        myCreatedStoryList.value =StoryCatListModel.fromJson(jsonDecode(res));
        print("================ storyCategoryListModels ${myCreatedStoryList.value.data?.last.images?.first.imageUrl!}");

      // });
      print("----------------prob 1");
    }
    else {
      print("----------------prob 1 ${response.reasonPhrase}");
      print(response.reasonPhrase);
    }
  }
  TextEditingController searchTextController = TextEditingController();
}
