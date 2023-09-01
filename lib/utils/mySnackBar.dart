import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_color.dart';

class MySnackBar {
  static snackBarPrimary({required String title,required String message,}) {
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   duration: Duration(seconds: 3),
    //   content: Text(message),
    //   backgroundColor: AppColors.kPrimary,
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //           topRight: Radius.circular(10), topLeft: Radius.circular(10))),
    // ));
    Get.snackbar(title, message,
        colorText: AppColors.kWhite,
        backgroundColor: AppColors.kPrimary,
        snackPosition: SnackPosition.BOTTOM,
        isDismissible:true,
        margin: EdgeInsets.only(bottom: 10,left: 10,right: 10)

    );
  }
  static snackBarSessionOut({required String title,required String message,}) {
    // Get.snackbar(title, message,
    //     colorText: AppColors.kWhite,
    //     backgroundColor: AppColors.red,
    //     snackPosition: SnackPosition.BOTTOM,
    //     isDismissible:false,
    //     overlayBlur: 3,
    //     margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
    //     snackbarStatus: (val){
    //       print("====snack: $val.=======");
    //       if(val ==SnackbarStatus.CLOSED){
    //        GetStorage().erase();
    //        Get.offAll(SplashScreen());
    //       }
    //
    //
    //     }
    //
    // );
    Get.defaultDialog(
        title: title,
        middleText:message,
        backgroundColor: AppColors.kWhite,
        titleStyle: TextStyle(color: AppColors.kPrimary),
        middleTextStyle: TextStyle(color: AppColors.kPrimary,),
        radius: 30,
        textCancel: "OK",
        buttonColor:AppColors.kPrimary ,
        cancelTextColor:AppColors.kPrimary ,
        onCancel: (){
          // GetStorage().erase();
          // Get.offAll(SplashScreen());
        }
    );
  }

  static snackBarRed({required String title,required String message}) {

    Get.snackbar(title, message,
        colorText: AppColors.kWhite,

        backgroundColor: AppColors.kRed,

        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(bottom: 10,left: 10,right: 10)
    );

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   duration: Duration(seconds: 3),
    //   content: Text(text),
    //   backgroundColor: AppColors.kRed,
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //           topRight: Radius.circular(10), topLeft: Radius.circular(10))),
    // ));
  }

  static snackBarYellow({required String title,required String message}) {

    Get.snackbar(title, message,
        colorText: AppColors.kWhite,

        backgroundColor: AppColors.kPrimary,

        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(bottom: 10,left: 10,right: 10)
    );

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   duration: Duration(seconds: 3),
    //   content: Text(text),
    //   backgroundColor: AppColors.kRed,
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //           topRight: Radius.circular(10), topLeft: Radius.circular(10))),
    // ));
  }
}