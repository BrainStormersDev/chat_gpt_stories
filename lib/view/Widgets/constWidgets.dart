import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../utils/app_color.dart';
import '../../utils/app_size.dart';

Widget storyByGptWidget (BuildContext context) {
  AppSizes().init(context);
  return   Row(
    // mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
          height: MediaQuery.of(context).size.height*0.04,
          child: Image.asset("assets/PNG/gridIcon.png")),
         // SizedBox(
      //   width: MediaQuery.of(context).size.width * 0.03,
      // ),
      const Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Text(
          "Story",
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: "BalooBhai",
              color: AppColors.kBtnColor),
        ),
      ),
      const Text(
        "By GPT",
        style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: "BalooBhai",
            color: AppColors.txtColor1),
      ),
      const Spacer(),


      SizedBox(
          height: MediaQuery.of(context).size.height*0.04,
          child: Image.asset("assets/PNG/bellIcon.png")),


    ],
  );
  //   Row(
  //   mainAxisAlignment: MainAxisAlignment.center,
  //   children: const [
  //     Text(
  //       "Story ",
  //       style: TextStyle(
  //           fontSize: 30,
  //           fontWeight: FontWeight.bold,
  //           fontFamily: "BalooBhai",
  //           color: AppColors.kBtnColor),
  //     ),
  //     Text(
  //       "By GPT",
  //       style: TextStyle(
  //           fontSize: 30,
  //           fontWeight: FontWeight.bold,
  //           fontFamily: "BalooBhai",
  //           color: AppColors.txtColor1),
  //     ),
  //   ],
  // );
}