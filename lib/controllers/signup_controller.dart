import '../../utils/MyRepo.dart';
import '../../utils/apiCall.dart';
import '../../utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/Pages/story_category_page.dart';

class SignUpController extends GetxController {
  RxBool isLoading = true.obs;
  signUpUser(name, email, password) async {
    var body = {
      "email": "${email.toString()}",
      "name": "${name.toString()}",
      "password": "${password.toString()}"
    };

    ApisCall.multiPartApiCall("${kBaseUrl}api/v1/register", "post", body,header: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'

    }).then((value) {
      if (value["isData"] == true) {
        isLoading.value = false;
        Get.offAll(() => StoryCategoryPage());
      } else if (value["isData"] == false) {
        isLoading.value = false;
      }
    });
  }

}
