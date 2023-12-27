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
  // RxList<DataList> product = <DataList>[].obs;
  RxString filter = ''.obs;
  // String header =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNTZmNmY3MWUwNjRmMjNiYTI4NjIxZmRjNjY4ODJjYWM4ODM5MGExODU4NjE2NWY4ZTJhMmQwM2JmOTAwZmQ1NDUzNWI4NjNiZTJmMjY2YjUiLCJpYXQiOjE2ODY5MTE2ODguMDYwODkyLCJuYmYiOjE2ODY5MTE2ODguMDYwODk1LCJleHAiOjE3MTg1MzQwODguMDU3MzQ1LCJzdWIiOiI5NiIsInNjb3BlcyI6W119.rTUyNMPAh4jHrCPscawaJvOaPwLdQuCHqiQtWKzEwG-zT3Tx8smm4V9Bd9fGM1rL4SWcJCCsbDM32548gdPKsQN5q1HFEcRA1r99z9Af0P87f1OPZehdKvqyxBtLzKIt4WyhXu_lpVM_wl2YaPd3s_JzUOvcD4aN4_uQ3FbEe9Iac4_4gPdKeTJxinNK2iPRGnsYHAbGQ-rE1giyszSHYarEmIp4bbzb9_o0Kz-h2eHlmAWlVVU677arg8dRn3UENbWJj9VyqU3xKSYlhI2CLD1kDBERNkZll3EsWEfT_f4vQ6Alzy_vNR0iE44zBzc2Fca-NMy3nGgaL2_QTqFuCJ8DQIhAIIKwtZkzrJ7GB83j1Xxm7LwSwFjkiVKtT91IBodmTbcKKNnKWkPKiwxmFnMEDLdCRUm5C-MVKUxNcI29vHk-hz0RTnXl-Aw7trGw1Y1LPW9tVr4OEWZhPvaO6Kz26t9RDVfn5neP6pHbhC-SeCGTjWnDzIGSVMza3308bL0HugSMO6slsgiaUmd6LmMSdBy3VERm6ydXTQ3O9kM2VoxHj35uBfl05BYRT01FtjDOuy8BVBjQDmCbcITgGUPd1RW671Obo9WQwhlYqiN9JeqosMWmv9WwvL2BHZrDxgF3Ti3xs9-jhm72q6__6AK9vYm_an0vZRyLYC7vmmY";
  Rx<StoryWatchedModel> storyCategoryModels =
      StoryWatchedModel(status: false, message: '', data: []).obs;
  var token;
  @override
  void onInit() {
    print("========fff========");
    getWatchedStory();
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
  getWatchedStory() async {
    print("========= MyRepo.bearerToken :${GetStorage().read("bearerToken")}");
 if(GetStorage().read("bearerToken").toString().isNotEmpty){
 token = GetStorage().read("bearerToken");
 }
print("============== <token> $token");
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('GET', Uri.parse('http://story-telling.eduverse.uk/api/v1/user/viewed-stories'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("========= status ${ storyCategoryModels.value.message}");
    print("=========  statis code ${ response.statusCode}");
    if (response.statusCode == 200) {
            var res=await response.stream.bytesToString();
            storyCategoryModels.value = StoryWatchedModel.fromJson(json.decode(res));
            print("=========== length :${storyCategoryModels.value.data!.length}");
          }
          else {
                  print(response.reasonPhrase);
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
  // getWatchedStory() async {
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZTM3NTg1ZTMxNGU4NDMyNjllNjY5YWIyY2QxZWViYWMzYmE3MWFiOGIyMGYyNDllMjRkNWExYWM2M2M0NmQ1ZTNkMGZjNzA1YjM3OTA4MmYiLCJpYXQiOjE2ODcxODIxODIuOTEwMDMsIm5iZiI6MTY4NzE4MjE4Mi45MTAwMzMsImV4cCI6MTcxODgwNDU4Mi45MDYzNzMsInN1YiI6Ijk2Iiwic2NvcGVzIjpbXX0.XaEekN7k5_1RHrWhrrta_XAq9BSJF7koVxgqi0_LXGMQX08uzo6P_0aZ_uThoEynW-v6Q4WzMTrxmApsSq0zUKAQRngdMIuQoIi5HDoPs0CbytxWq-HoZGvs5MBAnZ8mo02D3Wux4NHV_bPWoTN2dt5-2YTcJVYW3w9yH572ke2f0q7_AH7Vx1RwMyEYIv3i8GFU7cXvi4X4kKv-uY7BqLJc5aToa-wdToMhD2Z1nL3N2wQALCxr7cGaiV5cl4imhSOyepkeym5LDAYmJ7o5qgxNyo2iyyh1xsg-eWNZ2qGGWU-4lia_V_mUPWnG90mcuGiSdxuBLX8txZwMavJp49bENHEbRRpC_BNSa4sz-RF40-8TUMS5kdh73KgBxoq_oY9LjsdpC-p_d4Z-OOApDWgJ-3g8vpP-JCP-mLGc6J4ZEFTzfg-5Ry8bj_TeCCIqHUg3g80JU2iYLH82yQCZrivk4ujzm4pBxcpi8K1fzpl7mA9ponN1m5EXDvbcsqXfnnAL3okxs_FXLjW9mQvc4Nwvl2u4xULnbaMn51UoLAQYJ1QW14sfNQ_9BV61XmmWAH9J8kM5XJY4QbwR5E2cURl3Lx-oxpO6IKgZcdLX0BJnsV8cRVHP9wl84TLCl-pH3bH1a8EH01b6GLN9KdY8ZUWBqxupeOIBPoM5FiGv4lY'
  //   };
  //   var request = http.MultipartRequest('GET', Uri.parse('http://story-telling.eduverse.uk/api/v1/user/viewed-stories'));
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     // print(await response.stream.bytesToString());
  //     storyCategoryModels.value = StoryWatchedModel.fromJson(json.decode(await response.stream.bytesToString()));
  //   }
  //   else {
  //   print(response.reasonPhrase);
  //   }
  //
  // }
}
