import 'package:chat_gpt_stories/utils/MyRepo.dart';
import 'package:chat_gpt_stories/utils/apiCall.dart';
import 'package:chat_gpt_stories/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/Pages/story_category_page.dart';

class SignUpController extends GetxController {
  RxBool isLoading = true.obs;
  signUpUser(name, email, password) async {
    var body = {
      "email": "$email",
      "name": "$email",
      "password": password
    };
    // isLoading.isTrue
    //     ? Get.defaultDialog(
    //         backgroundColor: Colors.transparent,
    //         content: const CircularProgressIndicator(
    //           color: AppColors.kBtnColor,
    //         ))
    //     : null;
    ApisCall.apiCall("${kBaseUrl}register", "post", body).then((value) {
      if (value["isData"] == true) {
        isLoading.value = false;
        Get.offAll(() => StoryCategoryPage());
      } else if (value["isData"] == false) {
        isLoading.value = false;
      }
    });
  }
}
