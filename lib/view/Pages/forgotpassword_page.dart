import '../../utils/apiCall.dart';
import '../../utils/app_color.dart';
import '../../utils/app_size.dart';
import '../../utils/mySnackBar.dart';
import '../../utils/my_indicator.dart';
import '../../view/Pages/createPassword_page.dart';
import '../../view/Pages/login_page.dart';
import '../../view/Widgets/appTextField.dart';
import '../../view/Widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/MyRepo.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kSplashColor,
      body: SafeArea(
        child: Obx(()=>
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 6),
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
                    height: 20,
                  ),
                  const Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: "BalooBhai",
                        color: AppColors.txtColor1),
                  ),
                  Text(
                      "Don't worry! It occurs. Please enter the email address linked with your account."),
                  SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    textEditingController: emailController,
                    hintTxt: "Enter your email",
                    validation: (val) {
                      if (val!.isEmpty || val == "") {
                        return "required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  isLoading.value == false
                      ? CustomButton(
                          text: "Send Code",
                          height: MediaQuery.of(context).size.height * 0.08,
                          textSize: 18.0,
                          color: AppColors.kBtnColor,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if(emailController.text.contains("@")){

                                 isLoading.value=true;
                                ApisCall.apiCall(
                                    "${kBaseUrl}forgot-password", "post", { "email": emailController.text.trim()
                                }).then((value) {
                                  isLoading.value=true;
                                  if (value["isData"] == true) {
                                    Get.to(() => CreatePasswordPage());
                                    isLoading.value=false;
                                  }
                                  else if(value["isData"] == false){
                                    isLoading.value=false;
                                  }
                                });
                              }
                              else{
                                MySnackBar.snackBarRed(title: "Alert", message: "The email must be a valid email address.");
                              }

                            }
                          },
                        )
                      : myIndicator(),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Remember Password? "),
                      GestureDetector(
                          onTap: () {
                            Get.close(1);
                            Get.to(() => LogInPage());
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: AppColors.kBtnTxtColor),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
