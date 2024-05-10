import '../../utils/MyRepo.dart';
import '../../utils/app_color.dart';
import 'package:flutter/cupertino.dart';

Widget storyByGptWidget (BuildContext context) {
  return   Row(
    // mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
          height: 27,
          child: Image.asset("assets/PNG/gridIcon.png")),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.03,
      ),
       Text(
        "AI Stories ",
        style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: "BalooBhai",
            color: AppColors.kBtnColor),
      ),
      Text(
        "for ",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "BalooBhai",
            color: AppColors.txtColor1),
      ),
       Text(
        "Kids",
        style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: "BalooBhai",
            color: AppColors.txtColor1),
      ),
      const Spacer(),
      // SizedBox(
      //     height: 30,
      //     child: Image.asset("assets/PNG/bellIcon.png")),
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