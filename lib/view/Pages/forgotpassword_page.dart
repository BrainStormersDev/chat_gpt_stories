import '../../utils/MyRepo.dart';
import '../../utils/apiCall.dart';
import '../../utils/app_color.dart';
import '../../utils/mySnackBar.dart';
import '../../utils/my_indicator.dart';
import '../../view/Pages/login_page.dart';
import '../../view/Widgets/appTextField.dart';
import '../../view/Widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'createPassword_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(


        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDDFE9),
              Color(0xFFB6E7F1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),



        child: Obx(()=>
           Padding(
             padding: const EdgeInsets.only(top:50.0,
               left:8,
               right:8,

             ),
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
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              if(emailController.text.contains("@")){

                                 isLoading.value=true;
                                ApisCall.multiPartApiCall(
                                    "${v1}forgot-password", "post",
                                    { "email": emailController.text.trim()},
                                  header:  {
                                    'Accept': 'application/json',
                                    'Content-Type': 'application/json'
                                  }
                                ).then((value) {
                                  isLoading.value=true;
                                  if (value["isData"] == true) {
                                    Get.to(() => CreatePasswordPage(email:emailController.text.trim()));
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

                            // var headers = {
                            //   'Accept': 'application/json',
                            //   'Content-Type': 'application/json'
                            // };
                            // var request = http.MultipartRequest('POST',
                            //     Uri.parse('https://gptstory.thebrainstormers.org/api/v1/forgot-password'));
                            // request.fields.addAll({
                            //   'email': 'maryamshabbirahmed@gmail.com'
                            // });
                            //
                            // request.headers.addAll(headers);
                            //
                            // http.StreamedResponse response = await request.send();
                            //
                            // if (response.statusCode == 200) {
                            //   print(await response.stream.bytesToString());
                            // }
                            // else {
                            // print(response.reasonPhrase);
                            // }


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
                          child:  Text(
                            "Login",
                            style: TextStyle(color: AppColors.kBtnColor),
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
