import 'package:chat_gpt_stories/utils/app_color.dart';
import 'package:flutter/cupertino.dart';

Widget storyByGptWidget () {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text(
        "Story ",
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "BalooBhai",
            color: AppColors.kBtnColor),
      ),
      Text(
        "By GPT",
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "BalooBhai",
            color: AppColors.txtColor1),
      ),
    ],
  );
}