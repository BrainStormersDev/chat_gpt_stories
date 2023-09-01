import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kids_stories/view/Pages/signup_page.dart';
import 'package:kids_stories/view/Pages/story_category_page.dart';
import '../../controllers/nLogin_controller.dart';
import '../../utils/MyRepo.dart';
import '../../utils/apiCall.dart';
import '../../utils/app_color.dart';
import '../../utils/app_size.dart';
import '../../utils/mySnackBar.dart';
import '../../utils/my_indicator.dart';
import '../Widgets/appTextField.dart';
import '../Widgets/customButton.dart';
import 'forgotpassword_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:async';
import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';








class LogInPage extends StatelessWidget {
  LogInPage({Key? key}) : super(key: key);
  LoginController logInContoller = Get.put(LoginController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  RxBool isLoading = false.obs;
  RxBool isSignGoogleClicked = false.obs;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return WillPopScope(
      onWillPop: () async {
        // SystemNavigator.pop();
        Get.back();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.kSplashColor,
        body: Obx(
          () => SafeArea(
            child:
                // logInContoller.isLoading.value==false?myIndicator():
                SingleChildScrollView(
                 child: Form(
                   key: _formKey,
                   child: Stack(
                     children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                           Row(
                             children: [
                               GestureDetector(
                                 onTap: () {
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
                                       padding: EdgeInsets.symmetric(
                                           horizontal: 6, vertical: 6),
                                       child: Icon(Icons.arrow_back_ios_sharp,),
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
                             "Welcome back! We are happy to see you, Again!",
                             style: TextStyle(
                                 fontSize: 28,
                                 fontWeight: FontWeight.bold,
                                 fontFamily: "BalooBhai",
                                 color: AppColors.txtColor1),
                           ),
                           SizedBox(
                             height: MediaQuery.of(context).size.height*0.02,
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
                             height: MediaQuery.of(context).size.height*0.02,
                           ),
                           AppTextField(
                             textEditingController: passwordController,
                             hintTxt: "Enter your password",
                             validation: (val) {
                               if (val!.isEmpty || val == "") {
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
                           Align(
                             alignment: Alignment.centerRight,
                             child: GestureDetector(
                                 onTap: () {
                                   Get.to(() => ForgotPasswordPage());
                                 },
                                 child: const Text("Forgot Password?")),
                           ),
                           SizedBox(
                             height: MediaQuery.of(context).size.height*0.02,
                           ),
                           isLoading.value == false
                               ? CustomButton(
                                   text: "LogIn",
                                   height: MediaQuery.of(context).size.height * 0.08,
                                   textSize: 18.0,
                                   color: AppColors.kBtnColor,
                                   onTap: () {
                                     // isLoading.value=true;
                                     if (_formKey.currentState!.validate()) {
                                       isLoading.value = true;
                                       // logInContoller.getLogin(emailController.text.trim(),passwordController.text.trim());
                                       var body = {
                                         "email": emailController.text.trim(),
                                         "password": passwordController.text.trim()
                                       };
                                       ApisCall.apiCall(
                                               "${kBaseUrl}login", "post", body)
                                           .then((value) {
                                         if (value["isData"] == true) {

                                           print("====Login btn clicked = user email ${ jsonDecode(value["response"])["data"]
                                           ["email"]}==");
                                           GetStorage().write(
                                               "userEmail",
                                               jsonDecode(value["response"])["data"]
                                                   ["email"]);
                                           GetStorage().write(
                                               "userName",
                                               jsonDecode(value["response"])["data"]
                                               ["name"]);
                                           GetStorage().write(
                                               "bearerToken",
                                               jsonDecode(value["response"])[
                                                   "access_token"]);
                                           GetStorage().write(
                                               "userId",
                                               jsonDecode(value["response"])["data"]
                                                   ["id"]);
                                           print(
                                               "====read data ${GetStorage().read("userEmail")}===");
                                           // MyRepo.islogInHomeScreen == true
                                           //     ?
                                           Get.close(2);
                                           Get.to(()=>StoryCategoryPage());
                                               // : Get.to(() => RateUsPage());
                                           isLoading.value = true;
                                          // MyRepo.islogIn=true;
                                           GetStorage().write("isLogIn", true);

                                         } else if (value["isData"] == false) {
                                           isLoading.value = false;
                                         }
                                         print("====== ${isLoading.value}");
                                       });
                                     } else {
                                       isLoading.value == false;
                                       MySnackBar.snackBarRed(
                                           title: "Alert",
                                           message: "Email and Password Required");
                                     }
                                   },
                                 )
                               : myIndicator(),
                           SizedBox(
                             height: MediaQuery.of(context).size.height*0.02,
                           ),
                               const Row(
                             children:  [
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
                             height: MediaQuery.of(context).size.height*0.02,
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               // Expanded(
                               //        child: GestureDetector(
                               //         onTap: () {
                               //           // _handleFaceBookSignIn();
                               //           // facebookLogin();
                               //
                               //         },
                               //         child: Image.asset(
                               //           "assets/PNG/facebook_btn.png",
                               //           height: 60,
                               //         ))),
                               Expanded(
                                   child: GestureDetector(
                                       onTap: () async {
                                         print("============= clicked signin with google btn ====");

                                         // handleSignIn();
                                         // await signInWithGoogle(context);
                                         // myIndicator();

                                         _signInWithGoogle(context);
                                       },
                                       child: Image.asset(
                                         "assets/PNG/googleIcon-removebg-preview.png",
                                         height: AppSizes.appVerticalXL,
                                         width: MediaQuery.of(context).size.width,
                                       ))),
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
                             const  Text("Don’t have an account?"),
                               GestureDetector(
                                   onTap: () {
                                     Get.to(() => SignInPage());
                                   },
                                   child:const Text(
                                     " Register Now",
                                     style: TextStyle(color: AppColors.kBtnTxtColor),
                                   ))
                             ],
                           )
                         ],
                 ),
                       ),
                       isSignGoogleClicked.value==true?    Container(
                         color: AppColors.kBlack.withOpacity(0.3),
                         height: MediaQuery.of(context).size.height,
                         width: MediaQuery.of(context).size.width,
                         child: myIndicator(),
                       ):const SizedBox()
                     ],
                   ),
                ),
              ),
          ),
        ),
      ),
    );
  }


  Future<void> _handleFaceBookSignIn() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        // TODO: Handle signed in user
      } else {
        print('Facebook sign-in failed');
      }
    } catch (error) {
      print("===== error $error");
    }
  }

  // facebookLogin() async {
  //   print("=============> FaceBook <============");
  //   try {
  //     final result =
  //     await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
  //     if (result.status == LoginStatus.success) {
  //       final userData = await FacebookAuth.i.getUserData();
  //       print(userData);
  //     }
  //   } catch (error) {
  //     print("===========> error $error");
  //   }
  // }

  Future<void> _signInWithGoogle(context) async {
    var auth = FirebaseAuth.instance;
    isSignGoogleClicked.value=true;
    // print("======== prob 1======== ${await GoogleSignIn().signIn()}");
    // print("======== prob auth======== ${await auth.currentUser}");
    try {
      // final QuerySnapshot snapshot = await firestore.collection('Users').get();
      // final List<String> documents = snapshot.docs.map((e) => e.id).toList();

      final GoogleSignInAccount? googleSignOutAccount;
      googleSignOutAccount= await _googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      print("======== prob =====2=== '");

      // if(await _googleSignIn.isSignedIn()){
      //   print("======== ifffffffff ========");
      //   MySnackBar.snackBarYellow(title: "LogIn", message: "Already Logged In");
      //   Get.close(2);
      // }
      // else{
      print("======== elseeeee ========");
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken,);
      final UserCredential userCredential = await auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      var body={
        "name":"${user!.displayName}",
        "email":"${user.email}",
        "auth_type":"google",
      };

      ApisCall.apiCall("http://story-telling.eduverse.uk/api/v1/social-auth", "post", body).then((value){
        if(value["isData"]==true){
          // MyRepo.islogIn = true;
          GetStorage().write("isLogIn", true);
          GetStorage().write("userEmail", jsonDecode(value["response"])["data"]["email"]);
          GetStorage().write("userName", jsonDecode(value["response"])["data"]["name"]);
          // ApisCall.apiCall("http://story-telling.eduverse.uk/api/v1/social-auth", "post", body).then((value) {
          //   if (value["isData"] == true) {
              GetStorage().write("userEmail", jsonDecode(value["response"])["data"]["email"]);
              GetStorage().write("userName", jsonDecode(value["response"])["data"]["name"]);
             GetStorage().write("userId", jsonDecode(value["response"])["data"]["id"]);
              print("================ <login token > ${jsonDecode(value["response"])["access_token"]}");
              GetStorage().write("bearerToken", jsonDecode(value["response"])["access_token"]);
              Get.close(2);
              Get.to(StoryCategoryPage());
              isSignGoogleClicked.value=false;
          //   }
          // });
          print("====================loign page =========== MyRepo.islogIn ${MyRepo.islogIn}");
        }
      });
      log("User signed in with Google: $user'");
      print("User signed in with Google: ${user.email}'");
      // }



      // documents.removeWhere((element) => element==user!.email.toString());

      // final signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(user!.email.toString());

      // if (signInMethods.isNotEmpty) {
      //   // User already exists.
      //   return true;
      // } else {
      //   // User does not exist.
      //   return false;
      // }
    }
    catch (e){
      MySnackBar.snackBarRed(title: "error", message: "$e");
      isSignGoogleClicked.value=false;
      print("======= error $e");
    }
  }
}
