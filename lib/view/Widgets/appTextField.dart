import 'package:flutter/material.dart';

import '../../utils/MyRepo.dart';
import '../../utils/app_color.dart';
class AppTextField extends StatefulWidget {
  TextEditingController textEditingController;
  String hintTxt;
  bool obsecureTxt;
  bool isTrailingIcon;
   String? Function(String?)? validation;

   AppTextField({Key? key,required this.textEditingController,required this.hintTxt,required this.validation,this.obsecureTxt=false,this.isTrailingIcon=false}) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      validator:widget.validation,
      obscureText: widget.obsecureTxt,
      cursorColor: AppColors.kBtnColor,
      decoration:  InputDecoration(
        hintText: widget.hintTxt,
        suffixIcon:widget.isTrailingIcon?  GestureDetector(onTap: (){
          setState(() {
            widget.obsecureTxt=!widget.obsecureTxt;
            print("=====obsecureTxt ${widget.obsecureTxt}");
          });

        },child:widget.obsecureTxt?  Icon(Icons.visibility,color: AppColors.kBtnColor,) : Icon(Icons.visibility_off,color: AppColors.kBtnColor,)):null,
        hintStyle:   TextStyle(color: AppColors.kGrey),
        enabledBorder:  OutlineInputBorder(
          borderSide:
          BorderSide(color: AppColors.textFieldColor, width: 2.0),
        ),
        filled: true,
        fillColor: AppColors.textFieldColor,
        focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: AppColors.kBtnColor)),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7.0),
          ),
        ),
      ),
    );
  }
}
