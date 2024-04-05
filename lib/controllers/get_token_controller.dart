// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gpt_chat_stories/utils/apiCall.dart';
// import '../../../common/headers.dart';
// import 'package:http/http.dart' as http;
// import '../model/TokenModels.dart';
// import '../utils/MyRepo.dart';
//
// class TokenController extends GetxController {
//   //TODO: Implement ChatImageController
//
//   @override
//   void onInit() {
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
//   late TokenModels tokenModels;
//
//
//
//   var state = ApiState.notFound.obs;
//
//   // Future <void>getToken() async {
//   //   state.value = ApiState.loading;
//   //   tokenModels =TokenModels(status: false,message: '',data:Data());
//   //
//   //   try {
//   //     final response = await http.get(
//   //       Uri.parse("${kBaseUrl}api/v1/getOpenAiKey"),
//   //     );
//   //
//   //     if(MyRepo.count.value ==5){
//   //
//   //       MyRepo.count.value==0;
//   //       state.value = ApiState.loading;
//   //
//   //
//   //     }
//   //
//   //     if (response.statusCode == 200) {
//   //
//   //       tokenModels = TokenModels.fromJson(jsonDecode(response.body));
//   //
//   //       print("=========before token: ${MyRepo.kApiToken.value}======");
//   //
//   //       desActiveToken(token:MyRepo.deviceToken.value );
//   //       MyRepo.kApiToken.value =tokenModels.data!.scretKey!;
//   //
//   //
//   //       print("=========after token: ${MyRepo.kApiToken.value}======");
//   //
//   //
//   //       print("success ");
//   //       state.value = ApiState.success;
//   //     } else {
//   //       print("Error in token controller  ${response.body} ");
//   //       // throw ServerException(message: "Image Generation Server Exception");
//   //       state.value = ApiState.error;
//   //     }
//   //   } catch (e) {
//   //     print("Error in catch area $e ");
//   //   } finally {
//   //    // searchTextController.clear();
//   //     update();
//   //   }
//   // }
//
//   Future <void>desActiveToken({required token}) async {
//
//     Map<String, dynamic> rowParams = {
//       "secret_key": token,
//     };
//     try {
//       ApisCall.apiCall("${kBaseUrl}register", "post", rowParams).then((value) {
//         if(value["isData"])
//           {
//
//             print("success desActiveToken ");
//
//
//           }
//         else
//           {
//
//             print("Error  desActiveToken");
//
//           }
//
//       });
//
//     } catch (e) {
//       print("Error $e ");
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
