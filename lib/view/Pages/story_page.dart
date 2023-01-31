import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_gpt_stories/view/Pages/story_view_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/headers.dart';
import '../../controllers/chat_image_controller.dart';
import '../../controllers/chat_text_controller.dart';
import '../../utils/app_color.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  // late PackageInfo packageInfo;
  bool versionCheck1 = false;
  String version = '';
  var playStoreUrl = '';

  @override
  void initState() {
    // TODO: implement initState

    versionCheck();
    super.initState();
  }
  Future<void> versionCheck() async {
    // for test
    // versionCheck1 = true;
    // packageInfo = await PackageInfo.fromPlatform();
    var url;
    setState(() {
      // version = packageInfo.version; //+'\n'+Platform.operatingSystemVersion;
    });
    url = Uri.parse("http://story-telling.eduverse.uk/api/v1/version");


    final response = await http.get(url);
    var data = jsonDecode(response.body);
    print("====data: ${data}=====");
    // if (response.statusCode == 200) {
    //   if (Platform.isAndroid) {
    //     if (packageInfo.version != data['data']["staff_app_version"]) {
    //       if (data['data']["staff_android_status"] == 0) {
    //         setState(() {
    //           versionCheck1 = true;
    //           playStoreUrl = data['data']["staff_app_url"];
    //         });
    //       }
    //     }
    //     // if (packageInfo.version != data['data']["staff_huawei_app_version"]) {
    //     //   if ((data['data']["staff_huawei_status"] == 0)) {
    //     //     setState(() {
    //     //       versionCheck1 = true;
    //     //       // playStoreUrl = "https://appgallery.huawei.com/app/C104569603";
    //     //       // playStoreUrl = data['data']["staff_app_url"];
    //     //       playStoreUrl = data['data']["staff_huawei_app_url"];
    //     //       // print("=====huawei playStoreUrl: $playStoreUrl========");
    //     //     });
    //     //   }
    //     // }
    //   } else if (Platform.isIOS) {
    //     if (packageInfo.version != data['data']["staff_iphone_app_version"]) {
    //       if (data['data']["staff_ios_status"] == 0) {
    //         setState(() {
    //           versionCheck1 = true;
    //           playStoreUrl = data['data']["staff_iphone_app_url"].toString();
    //           // print("=====playStoreUrl: $playStoreUrl========");
    //         });
    //       }
    //       if (data['data']["staff_ios_status"] == 3) {
    //         // isIOSCheck.value = false;
    //         // print("======isIOSCheck.value:${isIOSCheck.value}======");
    //       }
    //
    //     }
    //   }
    // }

   
  }
  @override
  Widget build(BuildContext context) {
    ChatImageController controllerImage= Get.put(ChatImageController());
    ChatTextController controllerText= Get.put(ChatTextController());


    RxString abc=''.obs;

    if (versionCheck1) {
      return Scaffold(
        body: Container(
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Update Available",
                        style: TextStyle(
                            color: AppColors.kPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            decoration: TextDecoration.underline),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: const Text(
                          "Please Update your app before using it",
                          style:
                          TextStyle(color: AppColors.kBlack, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                          onTap: () {
                            print("=====playStoreUrl:$playStoreUrl=====");
                            try {
                              launchUrl(Uri.parse(

                                  playStoreUrl
                              )
                                // playStoreUrl

                              );
                            } on PlatformException {
                              launchUrl(Uri.parse(
                                // "https://play.google.com/store/apps/details?id=com.americanlyceum.staff"
                                  playStoreUrl));
                            } finally {
                              launchUrl(Uri.parse(playStoreUrl
                                // "https://play.google.com/store/apps/details?id=com.americanlyceum.staff"

                              ));
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(2, 3),
                                    color: AppColors.kPrimary.withOpacity(0.2),
                                    blurRadius: 2.0,
                                    spreadRadius: 3.0)
                              ],
                              color: AppColors.kPrimary,
                              shape: BoxShape.rectangle,
                            ),
                            child: const Text(
                              "Update",
                              // ( Platform.isAndroid)? "Go to Play Store":"Go to App Store",
                              style: TextStyle(color: AppColors.kWhite),
                            ),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      // InkWell(
                      //   onTap: () async {
                      //
                      //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SplashScreen()), (Route<dynamic> route) => false);
                      //
                      //
                      //     //   login();
                      //   },
                      //   child: Container(
                      //       child: Text("Retry",style: TextStyle(color:AppColors.kPrimary ),)),
                      // ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "v $version",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.kBlack),
                  ),
                )
              ],
            )),
      );
    }
    else{
    return Scaffold(
      backgroundColor: AppColors.kScreenColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.kScreenColor,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);

          },
          icon: const Icon(Icons.arrow_back, color: AppColors.txtColor1,), ),
      ),
      body:SafeArea(
        child: Obx(()=>Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.06,
                // ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 27,
                        child: Image.asset("assets/PNG/gridIcon.png")),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                     Text(
                      "Story ${abc.value}",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: "BalooBhai",
                          color: AppColors.kBtnColor),
                    ),
                    const Text(
                      "By Chat GPT",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: "BalooBhai",

                          color: AppColors.txtColor1),
                    ),
                    const Spacer(),
                    SizedBox(
                        height: 30,
                        child: Image.asset("assets/PNG/bellIcon.png")),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Image.asset("assets/PNG/loin.png")),
                ),
                const Center(
                  child: Text(
                    "Listen Story",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "BalooBhai",
                        color: AppColors.txtColor1),
                  ),
                ),
                const SizedBox(height: 20,),
                controllerImage.state.value == ApiState.loading
                    ? const CircularProgressIndicator()
                    :Column(
                      children: [
                        InkWell(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context) => const StoryViewPage()));

                  },
                  child: Card(
                        child: CachedNetworkImage(
                          imageUrl: controllerImage.images.isEmpty?"":controllerImage.images[0].url,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.withOpacity(.3),
                                    highlightColor: Colors.grey,
                                    child: Container(
                                      height: 220,
                                      width: 130,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4)),
                                    ),
                                  )),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                  ),
                ),
                        const SizedBox(height: 35,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:  [
                            IconButton(
                                onPressed: (){},
                                icon: const Icon(Icons.skip_previous_rounded, color: AppColors.kBtnColor, size: 30,)),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const StoryViewPage()));
                              },
                              child: const CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColors.kBtnColor,
                                child: Icon(CupertinoIcons.play_arrow_solid, color: AppColors.txtColor1,),
                              ),
                            ),
                            IconButton(
                                onPressed: (){},
                                icon: const Icon(Icons.skip_next_rounded, color: AppColors.kBtnColor, size: 30,)),

                          ],
                        ),
                      ],
                    ),
                // SizedBox(
                //     height: MediaQuery.of(context).size.height * 0.4,
                //     child: Image.asset("assets/PNG/storyImg.png")),

                // ElevatedButton(
                //     onPressed: (){
                //       // Get.to(const AgePage());
                //       // Navigator.push(context, MaterialPageRoute(builder: (context) => const AgePage()));
                //     },
                //     style: ButtonStyle(
                //         shadowColor:  MaterialStatePropertyAll(AppColors.kBtnShadowColor),
                //         backgroundColor: const MaterialStatePropertyAll(AppColors.kBtnColor),
                //         shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
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
        )),
      ),
    );}
  }
}
