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

    // var response = await http.get(
    //   Uri.parse("${kBaseUrl}user/viewed-stories"),
    //   headers: {'Authorization': 'Bearer ${GetStorage().read("bearerToken")}'},
    // );
    //
    // // Check the response status code
    // if (response.statusCode == 200) {
    //   // Request was successful
    //   var responseBody = response.body;
    //   print(responseBody);
    // } else {
    //   // Request failed
    //   print('Request failed with status: ${response.statusCode}.');
    // }

    ///

// var token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjlhYTY3MTQ3MjY4MzM3OThmOGI5YWE2YzBmMmIzNjA2NGIyODRhNTUzYzEyYmEzNTU1OTFiZDY4YjQwYjY5NzU2ODRiODQ2MjQ1MTNmNWEiLCJpYXQiOjE2ODcxODczMDAuMjkxNzYsIm5iZiI6MTY4NzE4NzMwMC4yOTE3NjQsImV4cCI6MTcxODgwOTcwMC4yODgwNSwic3ViIjoiOTYiLCJzY29wZXMiOltdfQ.B2pOcLY9RL_YzyZR9PDiv3jm5tKQYSIUbm67llk7VMFPPcrZv5te3ZAczYpYoXSd3M_clW1YProZCPSLj9ozJwydQ-oRUDjOLGarwTwv7z3IiK3wI-2paE5fAdaf2CX-oyCKBMJ3_acHLF_d42wYneaglCqQFHdutOLxyGtzbFVD6BVTPCCBX8CMWQV-p-caNSHCOZOmUaZw5I-AgWsquk4yEkla1rzecMc1otIX_IjTJeU915VhZlV4-3bbbPF_Sjz2XKGt8Gty4fdFjKA_GMYOZ56tqK3TSIFA8bJkzWeKkeKaI4n4pFrSOAwzONguUuSq7lqEAUOVelD-B6-IiIGbjm1Ofw-4jX24Ji_lUnAS-tUYVnXlIzHl_5pQbxmnxKKNU8IRcDukwvVWHQ5vvPoM7cGbnLAhs-COFJhWh3BINOHo0UZuSL2BognFYvAo_88L3ZL1dQnDn2rRoFwXozqyf5Bz6W8-eeGQDrhe8SSTSNLpAtBHmxi4O75LeMUmGr5nDTpvobE980TW8LLuAq0RixiQDdif-4GUXQG2RNOvboJL3poKUw4gV55Kzwzw-g1Q_yJaoG2O7iaXYcN-3C1MhDcWUvi6uDfAfovS7qFi9ujQnSn46IlbFZNeWk-IQUCUKzeIrEbRSwqWTHAO-ngOs9BiwLld_FcMlGc77S4";
if(GetStorage().read("bearerToken").toString().isNotEmpty){
 token = GetStorage().read("bearerToken");
}


print("============== <token> $token");
// var token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGYzN2M4ZDg3MjNmNWUzYWNmNGUwYmMzYzZjYmNhMWI0ZjRiZWVkYjc0OWQyMWZlYzhiMjI4OGZmZTljNmI5MWY2NThiM2U5ZmNlOWEyNDIiLCJpYXQiOjE2ODcxODcxODkuMTE3OTY3LCJuYmYiOjE2ODcxODcxODkuMTE3OTcxLCJleHAiOjE3MTg4MDk1ODkuMTE0NzM0LCJzdWIiOiI5NiIsInNjb3BlcyI6W119.nYoi3S8K5peGdrYTOkXwjl9nwkeabh5bCj7tYemkO9Tn_gFdZLby9_7yohAGIVrWmQotuNUUGdk-orwCtpzno6WwfL-VCI_3dygyA59UaP629TcRcFnYLcq2VoEb-cMkZ963GfxrOEquTtJZlOHL8Ps5d4OTKrdGrKtiLMkmqaSm9qGeNGUSdeoG33Zs3fQFh3FjHpKH7ygPyt8Oxcf-8qyjPShCQxPSbraH009u0_4AUBzHBxiXKFsPOtE4IAfArRPlWKXm0lfWVQKL3t81sTes8ueJCFlUEiBcKp1XZ5DVR3gzpcdp9Hn3U_x1tKSaA_VNmgu0tqzLeAL-GzfxkV59WaNzLfc03gR8uDfL0lx4o6UxR5bP60zIhy7Hkre-nN3nsK10U6WgrNk_dn9sGU07sER254rR945rBqfUQgrWc5Oq3wqObPd7W4wt1A4uzyhrSTPd01j3GOsnUi_zFaqITxNjMbFUR5nqq3kYlfspBh-eR3D6fbQMbgIccFI9Htn4L4SU8BxeVH_83qICdu1IcnVILe6IqNnYFARt4znEscHANdxDib0UCoNHIyzuKaCaQeLZTpAtPyoPm4hfaQ0q9UFSgTRqYOvbh2AaBnWfTBTzzZ6g1PPnf8ydLdkjHZx4YbmwRNxxvoQVf4EtPP_6eeQ2OXWi0FiNZJdmm40";

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer $token'};
      'Authorization': 'Bearer $token'};
      // 'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNGNhYTY0ZTBlZmZiZDczNDJjYWQ3YmI2MmQ4OWQwNmM4ZDUyNGZkNTA5ZWJhYTI5ZDViM2RiYWFkNDc1MDdjMGExYTBmYjk1MTIxMWFlOGIiLCJpYXQiOjE2ODcxNzkwMjAuNjkwNjc4LCJuYmYiOjE2ODcxNzkwMjAuNjkwNjgxLCJleHAiOjE3MTg4MDE0MjAuNjg2NjI1LCJzdWIiOiI5NiIsInNjb3BlcyI6W119.v0hjHQ2sGqvRPfjSm7HrDc0VvHyN9ZkwAToCOC3IBbdBoGBoJ1EL_y-AWTnDbp66QEgGlQ02xQD1G4XUP84qZuts3QqpSZvgIaCJYczf1KTm32yK116BrjNUV3kORifV4U5tBLSmwRzP11DqL_HpeDfAXofDq-NAG4l46UOLxZoq2TkPC7e9Ih8l1yhaXa6lkPm-0GaZtmoFzhKOGLFOj5WLx6sbKNIiMzIJFWr4r4HxIrGU7Pw8q4NqhpcFCAJItAQglQJOhNWSZa8KRPW8UAtWs9lUA5uqk5bsUKCvA4KTbpuvwT8HuojCA1DUQf_8kta2G3X-psvQURmjf2UzsbqjX5ip2jQyRvu0zq8zT64ky_-_ih1x56UhoOXscod4N_PzvZPNAQ9GwRq6wK2wwaKl_Ng0JdL30CU_rKMpV946QOx7T-OQqe7XF1YDWdMa2t2IOc7o3j8FB9CuXhSYRpg__tqlCwGKjCgIuaY4cebXLC3QcUaCez9PTU5sWgYj5nlhx86fpF1MM8QK7vBsnAMeeW5GEs7FKo_EEfY0HaGeCtSkJ3w9ZByTQ55tpUio69005-gZcWSQ-lrX2HIbVQngSPDanltuUfAMwRdwZkQdK2gMb2xwpg2sQoJvcLdezkt_lNLY8OxrEmKbr-vwRp3OjJHgxKG4QWKzFs30Cno'};
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
