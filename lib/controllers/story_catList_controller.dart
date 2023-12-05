// import 'package:chat_gpt_stories/model/storyCatListModel.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:convert';
// import '../../../common/headers.dart';
// import 'package:http/http.dart' as http;
//
// import '../utils/MyRepo.dart';
//
// class StoryCatListController extends GetxController {
//   //TODO: Implement ChatImageController
//
//   @override
//   void onInit() {
//
//     // getCatList(storyCategoryListModels.subject.value!.search!.catId.toString());
//     super.onInit();
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
//
//   // List<ImageGenerationData> images = [];
//
//   Rx<StoryCatListModel> storyCategoryListModels =StoryCatListModel(status: false,message: '',data: []).obs;
//   RxString errorMsg=''.obs;
//
//   var state = ApiState.notFound.obs;
//
//   getCatList(String catId) async {
//     state.value = ApiState.loading;
//     // images.clear();
//
//     try {
//       Map<String, dynamic> rowParams = {
//         "cat_id": catId,
//       };
//
//       final response = await http.post(
//         Uri.parse("${kBaseUrl}get-stories"),
//         body: rowParams,
//         // headers: headerBearerOption(MyRepo.kApiToken.value),
//       );
//       storyCategoryListModels.value = StoryCatListModel.fromJson(json.decode(response.body));
//
//       if (storyCategoryListModels.value.status!) {
//         print("=====storyCategoryModels: ${storyCategoryListModels.value.data!.length},${storyCategoryListModels.value.message}=========");
//
//
//         if(storyCategoryListModels.value.data!.isEmpty) {
//           state.value = ApiState.notFound;
//         }
//         else {
//           state.value = ApiState.success;
//         }
//       }
//
//       else {
//         print("=====fffff====");
//         state.value = ApiState.error;
//       }
//     } catch (e) {
//       state.value = ApiState.error;
//       errorMsg.value = "Error :$e";
//       print("=====Errorrrrrrrrrrrrrrr$e====");
//       // print("Errorrrrrrrrrrrrrrr  ");
//     } finally {
//       // searchTextController.clear();
//       update();
//     }
//   }
//
//   TextEditingController searchTextController = TextEditingController();
//
//   clearTextField() {
//     searchTextController.clear();
//   }
// }
