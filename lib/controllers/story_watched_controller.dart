import 'dart:convert';

import '../../controllers/get_token_controller.dart';
import '../../model/storyCatListModel.dart';
import '../../model/story_watched_model.dart';
import '../../utils/MyRepo.dart';
import '../../utils/apiCall.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../common/headers.dart';
import '../../../model/text_completion_model.dart';
import '../model/GetStroyModels.dart';

class StoryWatchedController extends GetxController {
  //TODO: Implement ChatTextController
  RxString filter = ''.obs;
  Rx<StoryWatchedModel> storyCategoryModels =
      StoryWatchedModel(status: false, message: '', data: []).obs;
  var token;
  @override
  Future<void> onInit() async {
    print("========fff========");
    await getWatchedStory();
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
///before work
  Future<void> getWatchedStory() async {
    print("========= MyRepo.bearerToken :${GetStorage().read("bearerToken")}");
 if(GetStorage().read("bearerToken").toString().isNotEmpty){
 token = GetStorage().read("bearerToken");
 }
print("============== <token> $token");
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('GET',
        Uri.parse('http://gptstory.thebrainstormers.org/api/v1/user/viewed-stories'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
            var res=await response.stream.bytesToString();
            storyCategoryModels.value = StoryWatchedModel.fromJson(json.decode(res));
            print("=========== length :${storyCategoryModels.value.data!.length}");
          }
          else {
                  print("get watched stories ${response.reasonPhrase}");
          }



    ///
    //
    // final response = await http.get(Uri.parse("${kBaseUrl}user/viewed-stories"),
    //     headers: {
    //       // 'Accept': 'application/json',
    //       // 'Content-Type': 'application/json',
    //       // 'Authorization': 'Bearer${MyRepo.bearerToken}'
    //       'Authorization': 'Bearer ${GetStorage().read("bearerToken")}'
    //  }
    // );
    // storyCategoryModels.value = StoryWatchedModel.fromJson(json.decode(response.body));

    // print("=========  response.body ${ json.decode(response.body)}");
    print("=========  statis code ${ response.statusCode}");
    print("=========  response.body22 ${ storyCategoryModels.value.message}");
//     ApisCall.apiCall("${kBaseUrl}user/viewed-stories", "get","", header: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNjFlMmE2NTNiMzg1NGY1YTdlNzA1ZWM1NDI5ZTAzYWZkOWNhNTkxMGI1ZjM0ZWM2YjlkZTFhNzdjODY1YWI3MjUyMzM2ZDc2ZjkwYmUxNTgiLCJpYXQiOjE2ODY4OTc4NTcuNjE3MzA0LCJuYmYiOjE2ODY4OTc4NTcuNjE3MzA4LCJleHAiOjE3MTg1MjAyNTcuNjEyNDIxLCJzdWIiOiI5NiIsInNjb3BlcyI6W119.sf2AAX45M4gNTqcX5ac2akV_DZjsTXR4gBEw7W7Abff1XfEa3yypbt01SkO67wU8iL-g5PdCy3unoerP4ueutoz6HhGr2Xox6IIXR6gInn7hCGQF4trr4njsuOt4fFCZLw0tATIhJANwajWBm-ouw7nhbOJDwxDeNlbXFfA5FybCDWDWwJb_BCuZLwUch7SZfo5tSYaj_XmS3XFWz8ZqDqf8RXU3A3tC1-zNW44-W0wv9Xye7gpa-c7CHYkXs3jjwk1TayAQ_qTx0NVjq-r2H96GyKW-pHoC6Vj2FNlCitj_r74eY5mrfPFznuLvsTxJtONjCS1cUGkQBBMH1YNbot9c0UZqKRX36OVtBid5SCwAh0j6Ub2BZMQjCd4-4pihJzbz_bbLpxrBusm8F_BkNpu2bvFn907yT1RJkEATyG_od4h2vWemKnk8qB_U6ZrnToYo_ZxYXAycl6V7cfcp-DVWpB4O8taArP0Bgn3qUOVHDLPzB9MO0hydsugxyUqadcox-mOGBrUuBPrTxfJ76dd_qRhzLr5_mPCcXZmMUxbhZL_nq_6TRQTY2sR5Q-M6XK75kZI0_HjvPGYKL1mRJGYwtcUpTu_dX9EkpnuvNTRIufe9uuU_6YJoVtjGsVsuvZSi3ztPsE7giRHtT6c8a0BpjflRjyKpo05D6U_ay-U",)
//         .then((value){
//
// var data=StoryWatchedModel.fromJson(value["response"]);
//           print("============== response $data ");
//           if(json.decode(value["response"])){
//           }
//     });
  }

  ///testing

}
