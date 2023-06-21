import 'package:chat_gpt_stories/controllers/signup_controller.dart';
import 'package:chat_gpt_stories/utils/apiCall.dart';
import 'package:chat_gpt_stories/utils/app_color.dart';
import 'package:chat_gpt_stories/utils/app_size.dart';
import 'package:chat_gpt_stories/utils/mySnackBar.dart';
import 'package:chat_gpt_stories/utils/my_indicator.dart';
import 'package:chat_gpt_stories/view/Pages/login_page.dart';
import 'package:chat_gpt_stories/view/Pages/otp_page.dart';
import 'package:chat_gpt_stories/view/Pages/story_catList_page.dart';
import 'package:chat_gpt_stories/view/Widgets/appTextField.dart';
import 'package:chat_gpt_stories/view/Widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/MyRepo.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  SignUpController signUpController =Get.put(SignUpController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey=GlobalKey<FormState>();
  RxBool isLoading=false.obs;
  RxBool isSkipLoading=false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kSplashColor,
      // appBar: AppBar(
      //   leading:
      //   GestureDetector(
      //     onTap: (){
      //       Get.back();
      //     },
      //     child: Container(
      //       margin: EdgeInsets.all(8),
      //       decoration: BoxDecoration(
      //           color: AppColors.kWhite,
      //           borderRadius: BorderRadius.circular(14),
      //           border: Border.all(color: AppColors.kGrey)),
      //       child: const Center(
      //         child: Icon(
      //           Icons.arrow_back_ios_sharp,
      //           color: AppColors.kBlack,
      //         ),
      //       ),
      //     ),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: true,
      //   title:const Text(
      //     "Register to get started",
      //     style: TextStyle(
      //         fontSize: 28,
      //         fontWeight: FontWeight.bold,
      //         fontFamily: "BalooBhai",
      //         color: AppColors.txtColor1),
      //   ) ,
      // ),
      body: SafeArea(
        child: Obx(()=>
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
                      "Register to get started",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: "BalooBhai",
                          color: AppColors.txtColor1),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      textEditingController: nameController,
                      hintTxt: "Enter your name",
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      textEditingController: confirmPasswordController,
                      hintTxt: "Confirm password",
                      validation: (val){
                        if(val!.isEmpty || val==""){
                          return "required";
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 16,
                    ),
                     CustomButton(
                      text: "SignIn",
                      height: MediaQuery.of(context).size.height * 0.08,
                      textSize: 18.0,
                      color: AppColors.kBtnColor,
                      txtcolor: AppColors.kBtnTxtColor,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {

                          if(passwordController.text.trim()!=confirmPasswordController.text.trim() )
                            {
                              MySnackBar.snackBarRed(title: "Alert", message: "password didn't matched");
                            }
                          else{

                            signUpController.signUpUser(nameController.text.trim(), emailController.text.trim(), passwordController.text.trim());

                            // Get.to(() => OtpPage());
                          }
                        }
                        else{
                          MySnackBar.snackBarRed(title: "Alert", message: "all Fields are required");
                        }
                      }
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    isSkipLoading.value==false?     CustomButton(
                        text: "Skip for now",
                        textSize: 18.0,
                        height: MediaQuery.of(context).size.height * 0.08,
                        txtcolor: AppColors.kBtnTxtColor,
                        bordercolor: AppColors.kBtnTxtColor,
                        onTap: (){
                          isSkipLoading.value=true;
                          print("+======= aa ${MyRepo.rating}");
                          var body={
                            "story_id":"${MyRepo.currentStory.id}",
                            "rating": MyRepo.rating.toString()
                          };
                          ApisCall.apiCall("${kBaseUrl}story/rate", "post", body).then((value) {
                            if(value["isData"]){
                              isSkipLoading.value=true;
                              Get.close(4);
                              Get.to(StoryCatList(catName: MyRepo.storyCat.toString(),));
                              isSkipLoading.value=false;
                            }
                            else if(value["isData"]==false){
                              isSkipLoading.value=false;
                            }
                          });
                          print("====== rate us api calling todo ==> rate =${MyRepo.rating}===");

                        },
                        // color: AppColors.kBtnColor,
                        ):myIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Expanded(
                            child: Divider(
                          color: AppColors.kGrey,
                        )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Or Register with",
                            style: TextStyle(color: AppColors.kGrey),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          color: AppColors.kGrey,
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: GestureDetector(onTap: (){},child: Image.asset("assets/PNG/facebook_btn.png",height: 60,))),
                        Expanded(child: GestureDetector(onTap: (){},child: Image.asset("assets/PNG/google_btn.png",height: 60,))),
                      ],
                    ),
                    // const Spacer(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Already have an account?"),
                        GestureDetector(
                            onTap: () {
                              Get.close(1);
                              // Get.to(()=>LogInPage());
                            },
                            child: Text(
                              " Login Now",
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
      ),
    );
  }
}
