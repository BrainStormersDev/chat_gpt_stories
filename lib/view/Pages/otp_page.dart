import 'package:chat_gpt_stories/utils/app_size.dart';
import 'package:chat_gpt_stories/view/Pages/createPassword_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_color.dart';
import '../Widgets/customButton.dart';
import 'login_page.dart';
class OtpPage extends StatelessWidget {
  OtpPage({Key? key}) : super(key: key);
  final List<TextEditingController> _otpControllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  void _nextField(String value, int index) {
    if (value.length == 1 && index != 3) {
      _focusNodes[index].unfocus();
      _focusNodes[index + 1].requestFocus();
    }
    if (value.length == 0 && index != 0) {
      _focusNodes[index].unfocus();
      _focusNodes[index - 1].requestFocus();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kSplashColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.kWhite,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.kGrey)),
                      child: const Center(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                          child: Icon(
                            Icons.arrow_back_ios_sharp,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              const Text(
                "OTP Verification",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: "BalooBhai",
                    color: AppColors.txtColor1),
              ),
             const Text(
                  "Enter the verification code we just sent on your email address."),
             SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                      (index) => SizedBox(
                    width: 60.0,
                    child: TextFormField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      maxLength: 1,
                      onChanged: (value) {
                        _nextField(value, index);
                      },
                      cursorColor: AppColors.kBtnColor,
                      style:const TextStyle(fontSize: 24.0),
                      textAlign: TextAlign.center,
                      decoration:const InputDecoration(
                        filled: true,
                        fillColor: AppColors.kWhite,
                        focusColor: AppColors.kBtnColor,
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        counter: SizedBox.shrink(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.kBtnColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              CustomButton(
                text: "Verify",
                height: MediaQuery.of(context).size.height * 0.08,
                textSize: 18.0,
                color: AppColors.kBtnColor,
                txtcolor: AppColors.kBtnTxtColor,
                onTap: (){
                  String otp = _otpControllers.map((controller) => controller.text).join();
                print('Entered OTP: $otp');
                Get.to(()=>CreatePasswordPage());
                },
              ),
           const   Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                 const Text("Didn’t received code? "),
                  GestureDetector(
                      onTap: () {
                        Get.to(() => LogInPage());
                      },
                      child:const Text(
                        "Resend",
                        style: TextStyle(color: AppColors.kBtnTxtColor),
                      ))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
