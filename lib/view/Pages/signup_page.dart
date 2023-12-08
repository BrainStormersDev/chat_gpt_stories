import 'dart:convert';
import 'dart:developer';

import 'package:chat_gpt_stories/controllers/signup_controller.dart';
import 'package:chat_gpt_stories/utils/apiCall.dart';
import 'package:chat_gpt_stories/utils/app_color.dart';
import 'package:chat_gpt_stories/utils/app_size.dart';
import 'package:chat_gpt_stories/utils/mySnackBar.dart';
import 'package:chat_gpt_stories/utils/my_indicator.dart';
import 'package:chat_gpt_stories/view/Pages/login_page.dart';
import 'package:chat_gpt_stories/view/Pages/otp_page.dart';
import 'package:chat_gpt_stories/view/Pages/story_catList_page.dart';
import 'package:chat_gpt_stories/view/Pages/story_category_page.dart';
import 'package:chat_gpt_stories/view/Widgets/appTextField.dart';
import 'package:chat_gpt_stories/view/Widgets/customButton.dart';
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
                      height: MediaQuery.of(context).size.height*0.02,
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
                          _signInWithGoogle(context);
                          // _handleSignIn();
                          // final GoogleSignIn googleSignIn = GoogleSignIn();
                          //
                          // final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
                          // print("===== googleUser ${googleUser!.email}");

                          //
                          // try {
                          //
                          //
                          //
                          // //   var headers = {
                          // //     'Accept': 'application/json'
                          // //   };
                          // //   var request = http.MultipartRequest('POST', Uri.parse('http://story-telling.eduverse.uk/api/v1/social-auth'));
                          // //   request.fields.addAll({
                          // //     'name': googleSignIn.currentUser!.displayName.toString(),
                          // //     'email': googleSignIn.currentUser!.email.toString(),
                          // //     'auth_type': 'google'
                          // //   });
                          // //   request.headers.addAll(headers);
                          // //   http.StreamedResponse response = await request.send();
                          // //   if (response.statusCode == 200) {
                          // //     Get.close(1);
                          // //     print( await response.stream.bytesToString() );
                          // //
                          // //   }
                          // //   else {
                          // //     print(response.reasonPhrase);
                          // //   }
                          //   // final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
                          //   // final GoogleSignInAuthentication googleSignInAuthentication = await googleUser!.authentication;
                          //   //
                          //   // _googleSignIn.currentUser!.authentication;
                          //   // _googleSignIn.isSignedIn();
                          //
                          //   bool isSignedIn=  await  googleSignIn.isSignedIn();
                          //   if(isSignedIn){
                          //     // print("===== fetch data against email ====");
                          //   }
                          //   else{
                          //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
                          //     GoogleSignInAuthentication auth=await googleUser!.authentication;
                          //     FirebaseAuth.instance.signInWithCredential(GoogleAuthProvider.credential(accessToken: auth.accessToken,idToken: auth.idToken));
                          //     userEmail= await googleUser.email.toString();
                          //     print(  userEmail);
                          //   }
                          //   // print("========== google email  ${await  googleSignIn.isSignedIn()}=== ");
                          //   // final OAuthCredential credential = GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken,);
                          //   // TODO: Handle signed in user
                          //
                          // } catch (error) {
                          //   print("===== error ${error}===");
                          //   print(error);
                          // }

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
  Future<void> _signInWithGoogle(context) async {
    var auth = FirebaseAuth.instance;
    print("======== prob 1======== ${await GoogleSignIn().signIn()}");
    print("======== prob auth======== ${await auth.currentUser}");
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
          GetStorage().write(
              "userName",
              jsonDecode(value["response"])["data"]
              ["email"]);
          ApisCall.apiCall("http://story-telling.eduverse.uk/api/v1/social-auth", "post", body).then((value) {
            if (value["isData"] == true) {
              GetStorage().write(
                  "userName",
                  jsonDecode(value["response"])["data"]
                  ["email"]);
              GetStorage().write(
                  "bearerToken",
                  jsonDecode(value["response"])[
                  "access_token"]);
              Get.close(3);
              MyRepo.islogIn = true;
              Get.to(StoryCategoryPage());
            }
            MyRepo.islogIn = true;
          });}
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
      print("======= error $e");
  }
  }
}







