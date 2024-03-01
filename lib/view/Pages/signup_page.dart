import 'dart:convert';
import 'dart:developer';

import '../../controllers/signup_controller.dart';
import '../../utils/apiCall.dart';
import '../../utils/app_color.dart';
import '../../utils/app_size.dart';
import '../../utils/mySnackBar.dart';
import '../../utils/my_indicator.dart';
import '../../view/Pages/login_page.dart';
import '../../view/Pages/otp_page.dart';
import '../../view/Pages/story_catList_page.dart';
import '../../view/Pages/story_category_page.dart';
import '../../view/Widgets/appTextField.dart';
import '../../view/Widgets/customButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../utils/MyRepo.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  SignUpController signUpController =Get.put(SignUpController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
        child:
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
                      height: MediaQuery.of(context).size.height*0.02,
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
                      height: MediaQuery.of(context).size.height*0.02,
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
                      height: MediaQuery.of(context).size.height*0.02,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.02,
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
                      isTrailingIcon: true,
                      obsecureTxt: true,
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.02,
                    ),

                     CustomButton(
                      text: "Sign Up",
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
                    )
                       ,
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.02,
                    ),

                    CustomButton(
                        text: "Skip for now",
                        textSize: 18.0,
                        height: MediaQuery.of(context).size.height * 0.08,
                        txtcolor: AppColors.kBtnTxtColor,
                        bordercolor: AppColors.kBtnTxtColor,
                        onTap: (){
                          Get.offAll(() => StoryCategoryPage());

                        },
                        // color: AppColors.kBtnColor,
                        ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.02,
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
                     SizedBox(
                      height: MediaQuery.of(context).size.height*0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Expanded(child: GestureDetector(onTap: (){},child: Image.asset("assets/PNG/facebook_btn.png",height: 60,))),
                        Expanded(child: GestureDetector(onTap: () async {
                          await _signUpWithGoogle(context);
                        },child: Image.asset("assets/PNG/google_btn.png",height: 60,width: MediaQuery.of(context).size.width,))),
                      ],
                    ),
                    // const Spacer(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.02,
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
    );
  }

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      print("======= user ${user!.email}");

      // TODO: Handle signed in user
    } catch (error) {
      print("===== error  $error");
      print(error);
    }
  }
  // Future<void> _signInWithGoogle(context) async {
  //   isLoading.value=true;
  //   var auth = FirebaseAuth.instance;
  //   await GoogleSignIn().signIn();
  //   await auth.currentUser;
  //   try {
  //     final GoogleSignInAccount? googleSignOutAccount;
  //     googleSignOutAccount= await _googleSignIn.signOut();
  //     final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
  //   print("======== prob =====2=== '");
  //     print("======== elseeeee ========");
  //     final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
  //     final OAuthCredential credential = GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken,);
  //     final UserCredential userCredential = await auth.signInWithCredential(credential);
  //     final User? user = userCredential.user;
  //     var body={
  //       "name":"${user!.displayName}",
  //       "email":"${user.email}",
  //       "auth_type":"google",
  //     };
  //     ApisCall.apiCall("${kBaseUrl}api/v1/social-auth", "post", body).then((value){
  //       if(value["isData"]==true)
  //       {GetStorage().write("userName", jsonDecode(value["response"])["data"]["email"]);
  //       Get.close(3);
  //       MyRepo.islogIn = true;
  //       Get.offAll(StoryCategoryPage());
  //
  //       }
  //     });
  //   }
  // catch (e){
  //     print("======= error $e");
  // }
  // }
  Future<void> _signUpWithGoogle(context) async {
    isLoading.value=true;
    var auth = FirebaseAuth.instance;
    try {
      final GoogleSignInAccount? googleSignOutAccount;
      googleSignOutAccount= await _googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken,);
      final UserCredential userCredential = await auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      var body={
        "name":"${user!.displayName}",
        "email":"${user.email}",
        "auth_type":"google",
      };

      ApisCall.apiCall("${kBaseUrl}api/v1/social-auth", "post", body).then((value){
        if(value["isData"]==true){
          GetStorage().write(
              "userName",
              jsonDecode(value["response"])["data"]
              ["email"]);
          GetStorage().write("userId", jsonDecode(value["response"])["data"]["id"]);
          GetStorage().write(
              "bearerToken",
              jsonDecode(value["response"])[
              "access_token"]);
          MyRepo.islogIn = true;
          Get.to(StoryCategoryPage());
          // ApisCall.apiCall("${kBaseUrl}api/v1/social-auth", "post", body).then((value) {
          //   if (value["isData"] == true) {
          //     GetStorage().write(
          //         "userName",
          //         jsonDecode(value["response"])["data"]
          //         ["email"]);
          //   GetStorage().write("userId", jsonDecode(value["response"])["data"]["id"]);
          //     print("================ <login token > ${jsonDecode(value["response"])["access_token"]}");
          //
          //   }
          //   MyRepo.islogIn = true;
          // });
        }
      });
      // log("User signed in with Google: $user'");
      // logger.i("User signed in with Google: ${user.email}'");

    }
    catch (e){
      print("======= error $e");
    }
  }

}







