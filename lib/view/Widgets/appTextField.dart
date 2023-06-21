import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
class AppTextField extends StatelessWidget {
  TextEditingController textEditingController;
  String hintTxt;
  bool obsecureTxt;
   String? Function(String?)? validation;

   AppTextField({Key? key,required this.textEditingController,required this.hintTxt,required this.validation,this.obsecureTxt=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator:validation,
      obscureText: obsecureTxt,
      cursorColor: AppColors.kBtnColor,
      decoration:  InputDecoration(
        hintText: hintTxt,
        hintStyle:  TextStyle(color: AppColors.kGrey),
        enabledBorder:  OutlineInputBorder(
          borderSide:
          BorderSide(color: AppColors.textFieldColor, width: 2.0),
        ),
        filled: true,
        fillColor: AppColors.textFieldColor,
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.kBtnColor)),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7.0),
          ),
        ),
      ),
    );
  }
}
