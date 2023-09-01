import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/MyRepo.dart';
import '../../utils/apiCall.dart';
import '../../utils/app_color.dart';
import '../../utils/mySnackBar.dart';
import '../../utils/my_indicator.dart';
import '../Widgets/appTextField.dart';
import '../Widgets/customButton.dart';
import 'login_page.dart';

class CreatePasswordPage extends StatelessWidget {
  CreatePasswordPage({Key? key}) : super(key: key);
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final _formKey=GlobalKey<FormState>();
  RxBool isLoading = false.obs;
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

  RxBool passwordChanged=false.obs;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.kSplashColor,
        body: SafeArea(
          child:

          Obx(()=>
             Padding(
              padding: const EdgeInsets.all(8.0),
              child:
              passwordChanged.isFalse?
              SingleChildScrollView(
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
                    const  SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Create new password",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: "BalooBhai",
                            color: AppColors.txtColor1),
                      ),
                   const  Text("Your new password must be unique from those previously used."),
                     const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        textEditingController: newPasswordController,
                        hintTxt: "New Password",
                        validation: (val){
                          if(val!.isEmpty || val==""){
                            return "required";
                          }
                          return null;
                        },
                      ),
                     const SizedBox(
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
                    const  SizedBox(
                        height: 16,
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
                                contentPadding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 12),
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
                      const  SizedBox(
                        height: 8,
                      ),
                      isLoading.value==false?   CustomButton(
                        onTap: (){
                          print(newPasswordController.text.trim());
                          print(confirmPasswordController.text.trim());
                          if(_formKey.currentState!.validate()){
                            if(newPasswordController.text.trim()!=confirmPasswordController.text.trim()){
                              MySnackBar.snackBarRed(title: "Alert", message: "Password Didn't Matched");
                            }
                             else if(_otpControllers.any((element) => element.text.trim()=="" || element.text.trim().isEmpty)){
                                MySnackBar.snackBarRed(title: "Alert", message: "Check Your OTP Or Otp Didn't Matched");
                              }
                              else{
                              isLoading.value=true;
                              String otp = _otpControllers.map((controller) => controller.text).join();
                              print("===> user ${GetStorage().read("userName")} ==== new password ${newPasswordController.text.trim()} confirm ==> ${confirmPasswordController.text.trim()} ==>otp $otp"
                                  "");
                                var body={
                                  "email":GetStorage().read("userName"),
                                  "otp":otp,
                                  "password":newPasswordController.text.trim(),
                                  "password_confirmation":confirmPasswordController.text.trim()
                                  // "email":"farmaan@thebrainstormers.org",
                                  // "otp":"9849",
                                  // "password":"123456789",
                                  // "password_confirmation":"123456789"
                                };
                                ApisCall.apiCall("${kBaseUrl}reset-password","post", body).then((value){
                                  print("======= val :$value");
                                  if(value["isData"]==true){
                                    passwordChanged.value=true;

                                  }
                                  else if(value["isData"]==false){
                                    isLoading.value=false;
                                    // MySnackBar.snackBarRed(title: "Alert", message: value["message"]);
                                  }
                                });
                                  print("========= done ======");
                             }
                          }
                          else{
                            MySnackBar.snackBarRed(title: "Alert", message: "Check Your Password and OTP");
                          }
                          // passwordChanged.value=true;
                        },
                        text: "Reset Password",
                        height: MediaQuery.of(context).size.height * 0.08,
                        textSize:18.0 ,
                        color: AppColors.kBtnColor,
                      ):myIndicator(),

                    ],
                  ),
                ),
              ):
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Text(
                  "Password Changed!",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: "BalooBhai",
                      color: AppColors.txtColor1),
                ),
                SizedBox(   height: MediaQuery.of(context).size.height * 0.08,),
                Flexible(child: Image.asset("assets/PNG/done.png",height: 100,)),
                  SizedBox(   height: MediaQuery.of(context).size.height * 0.04,),

                const  Text("Your password has been changed successfully."),
                  SizedBox(   height: MediaQuery.of(context).size.height * 0.04,),

                  CustomButton(
                  text: "Back to Login",
                  height: MediaQuery.of(context).size.height * 0.08,
                  textSize:18.0 ,
                  color: AppColors.kBtnColor,
                    onTap: (){
                    Get.close(3);
                    Get.to(()=> LogInPage());
                    // Get.offAll(()=>LogInPage());
                    },
                ),

              ],)

              ,
            ),
          ),
        ),
      ),
    );
  }
}
