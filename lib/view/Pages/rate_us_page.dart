import '../../utils/MyRepo.dart';
import '../../utils/apiCall.dart';
import '../../utils/my_indicator.dart';
import '../../view/Pages/login_page.dart';
import '../../view/Pages/share_page.dart';
import '../../view/Pages/story_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/app_color.dart';
import '../Widgets/constWidgets.dart';
import '../Widgets/customButton.dart';

class RateUsPage extends StatelessWidget {
   RateUsPage({Key? key}) : super(key: key);
    RxInt colorNum=0.obs;
    RxBool isLoading=false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kScreenColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: storyByGptWidget(context),
        centerTitle: true,
        backgroundColor: AppColors.kScreenColor,
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
            // Get.close(1);
            Get.off(()=>StoryViewPage(data: MyRepo.currentStory));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.txtColor1,
          ),
        ),
      ),
      body: Obx(()=>
         Padding(
          padding:
              const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(
                //   height: 20,
                // ),
                const Text(
                  "Did you like your story",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "BalooBhai",
                      color: AppColors.txtColor1),
                ),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.74,
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                  MyRepo.emojiList.length,
                                  (index) => InkWell(
                                    onTap: (){
                                      colorNum.value=   index;
                                      print("===== test ${colorNum.value}");
                                    },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:  colorNum.value== index? MyRepo.emojiListColor[colorNum.value]:Colors.transparent,
                                              shape: BoxShape.circle
                                          ),
                                          child: Container(
                                            margin:const EdgeInsets.all(2),
                                            decoration:const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle
                                            ),
                                            child: Image.asset(
                                              MyRepo.emojiList[index],
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ))),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 10,
                        decoration: BoxDecoration(
                            color: MyRepo.emojiListColor[colorNum.value],
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   child: Image.asset("assets/PNG/rateus.png"),
                // ),
                SizedBox(
                  child: Image.asset("assets/PNG/people.png"),
                ),
                const Text(
                  "Your opinion matters to us!",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "BalooBhai",
                      color: AppColors.txtColor1),
                ),
                Text(
                  "We work super hard to make stories better for you, and would love to have your feedback. Please! Rate us",
                  style: TextStyle(color: AppColors.txtColor2, fontSize: 17),
                  textAlign: TextAlign.center,
                ),
                isLoading.value==true?myIndicator():  Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomButton(
                    onTap: () {
                      MyRepo.rating = (colorNum.value+1).toString();
                    isLoading.value=true;
                    if (GetStorage().read("userName")==null || GetStorage().read("userName")=="") {
                      MyRepo.islogInHomeScreen=false;
                      Get.to(() => LogInPage());
                    } else {
                      var body={
                        "story_id":"${MyRepo.currentStory.id}",
                        "rating": "${colorNum.value+1}"
                      };
                      ApisCall.apiCall("${kBaseUrl}story/rate", "post", body).then((value) {
                        if(value["isData"]){
                          // Get.close(5);
                          Get.to(SharePage(catName: MyRepo.storyCat.toString(),));
                          isLoading.value=false;
                        }
                        else if(value["isData"]==false){
                        isLoading.value=false;
                         }
                      });

                    }
                    },
                    color: AppColors.kBtnColor,
                    // height: MediaQuery.of(context).size.height*0.17,
                    width: MediaQuery.of(context).size.height * 0.15,
                    text: "Rate Us",
                    textSize: 20.0,
                    txtcolor: AppColors.kBtnTxtColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomButton(
                    onTap: () {
                      Get.to(() => const SharePage());
                    },
                    color: AppColors.kBtnColor,
                    // height: MediaQuery.of(context).size.height*0.17,
                    width: MediaQuery.of(context).size.height * 0.15,
                    text: "Next",
                    textSize: 20.0,
                    txtcolor: AppColors.kBtnTxtColor,
                  ),
                )
                // const SizedBox(height: 35,),
                // ElevatedButton(
                //     onPressed: (){
                //       // Get.to(const AgePage());
                //       Navigator.push(context, MaterialPageRoute(builder: (context) => SharePage()));
                //     },
                //     style: ButtonStyle(
                //         shadowColor:  MaterialStatePropertyAll(AppColors.kBtnShadowColor),
                //         backgroundColor: const MaterialStatePropertyAll(AppColors.kBtnColor),
                //         shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                //         fixedSize: MaterialStateProperty.all(Size(200, 50))
                //     ),
                //     child: const SizedBox(
                //         height: 50,
                //         // width: MediaQuery.of(context).size.width/2,
                //         child: Center(
                //             child: Text("Next",
                //                 style: TextStyle(color: AppColors.kBtnTxtColor, fontWeight: FontWeight.bold, fontSize: 18))))),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
