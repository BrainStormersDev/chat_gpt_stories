import '../../utils/MyRepo.dart';
import '../../utils/apiCall.dart';
import '../../utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/Pages/story_category_page.dart';

class LoginController extends GetxController{
   RxBool isLoading=true.obs;
  getLogin(email,password) async {
    var body={"email":"$email",
    "password":password
    };
    print("====== ${isLoading.value}");
    ApisCall.apiCall("${kBaseUrl}login","post",body).then((value) {
      if(value["isData"]==true){
        isLoading.value=false;
        Get.offAll(()=> StoryCategoryPage( ));
      }
      else if(value["isData"]==false){
        isLoading.value=false;
      }
      print("====== ${isLoading.value}");
    });
  }
}