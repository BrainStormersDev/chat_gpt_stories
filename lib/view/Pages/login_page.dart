
import 'dart:convert';

import 'package:chat_gpt_stories/utils/app_color.dart';
import 'package:chat_gpt_stories/utils/app_size.dart';
import 'package:chat_gpt_stories/utils/mySnackBar.dart';
import 'package:chat_gpt_stories/utils/my_indicator.dart';
import 'package:chat_gpt_stories/view/Pages/rate_us_page.dart';
import 'package:chat_gpt_stories/view/Pages/signup_page.dart';
import 'package:chat_gpt_stories/view/Pages/story_category_page.dart';
import 'package:chat_gpt_stories/view/Widgets/appTextField.dart';
import 'package:chat_gpt_stories/view/Widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/nLogin_controller.dart';
import '../../utils/MyRepo.dart';
import '../../utils/apiCall.dart';
import 'forgotpassword_page.dart';

class LogInPage extends StatelessWidget {
  LogInPage({Key? key}) : super(key: key);
  LoginController logInContoller =Get.put(LoginController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isLoading=false.obs;

  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        // SystemNavigator.pop();
        Get.back();
        return true;
      },
      child:
      Scaffold(
        backgroundColor: AppColors.kSplashColor,
        body: Obx(()=>
           SafeArea(
            child:
            // logInContoller.isLoading.value==false?myIndicator():
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              // SystemNavigator.pop();
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
                        height: 20,
                      ),
                      const Text(
                        "Welcome back! We are happy to see you, Again!",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: "BalooBhai",
                            color: AppColors.txtColor1),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        textEditingController: emailController,
                        hintTxt: "Enter your email",
                        validation: (val){
                          if(val!.isEmpty || val==""){
                            return "required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        textEditingController: passwordController,
                        hintTxt: "Enter your password",
                        validation: (val){
                          if(val!.isEmpty || val==""){
                            return "required";
                          }
                          return null;
                        },
                        isTrailingIcon: true,
                        obsecureTxt: true,
                      ),
                    const  SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector (onTap: (){Get.to(()=>ForgotPasswordPage());}, child: Text("Forgot Password?")),
                      ),
                     const SizedBox(
                        height: 16,
                      ),
                      isLoading.value==false?
                      CustomButton(
                        text: "LogIn",
                        height: MediaQuery.of(context).size.height * 0.08,
                        textSize:18.0 ,
                        color: AppColors.kBtnColor,
                        onTap: (){
                          // isLoading.value=true;
                          if(_formKey.currentState!.validate()){
                            isLoading.value=true;
                            // logInContoller.getLogin(emailController.text.trim(),passwordController.text.trim());
                            var body={"email":emailController.text.trim(),
                              "password":passwordController.text.trim()
                            };
                            ApisCall.apiCall("${kBaseUrl}login","post",body).then((value) {
                              if(value["isData"]==true){

                                print("====Login btn clicked===");
                                GetStorage().write("userName", jsonDecode(value["response"])["data"]["email"]);
                                GetStorage().write("bearerToken", jsonDecode(value["response"])["access_token"]);
                                GetStorage().write("userId", jsonDecode(value["response"])["data"]["id"]);
                                print("====read data ${GetStorage().read("userName")}===");
                                MyRepo.islogInHomeScreen==true?
                                Get.close(1):
                                Get.to(()=>  RateUsPage() );
                                isLoading.value=true;
                              }
                              else if(value["isData"]==false){
                                isLoading.value=false;
                              }
                              print("====== ${isLoading.value}");
                            });
                          }
                          else{
                            isLoading.value==false;
                            MySnackBar.snackBarRed(title: "Alert", message: "Email and Password Required");
                           }

                        },
                      ):myIndicator(),
                     const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children:const [
                          Expanded(
                              child: Divider(
                            color: AppColors.kGrey,
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Or Login with",
                              style: TextStyle(color: AppColors.kGrey),
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            color: AppColors.kGrey,
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                       Expanded(child: GestureDetector(onTap: (){},child: Image.asset("assets/PNG/facebook_btn.png",height: 60,))),
                       Expanded(child: GestureDetector(onTap: (){},child: Image.asset("assets/PNG/google_btn.png",height: 60,))),
                      ],),
                      // const Spacer(),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Don’t have an account?"),
                          GestureDetector(
                              onTap: (){Get.to(()=>SignInPage());},
                              child: Text(" Register Now",style: TextStyle(color: AppColors.kBtnTxtColor),))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
