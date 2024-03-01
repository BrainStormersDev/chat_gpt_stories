import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:gpt_chat_stories/view/Pages/storyfinish_page.dart';

import '../../model/storyCatListModel.dart';
import '../../utils/dynamic_link_provider.dart';
import '../../view/Pages/story_catList_page.dart';
import '../../view/Pages/story_category_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../utils/MyRepo.dart';
import '../../utils/app_color.dart';
import '../Widgets/constWidgets.dart';
import '../Widgets/customButton.dart';

class SharePage extends StatefulWidget {
  final DataList? shareData;
  final String? catName;

  const SharePage({Key? key, this.shareData, this.catName}) : super(key: key);

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  var shareStoryLink;

  @override
  void initState() {
    // TODO: implement initState
    getShare();
    super.initState();
  }

  getShare() async {
    shareStoryLink = await DynamicLinksProvider().createLink(
        MyRepo.storyCat.toString(), MyRepo.currentStory.storyTitle.toString());
    print("======shareStoryLink== $shareStoryLink");
  }

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
        // leading: IconButton(
        //   onPressed: () {
        //     Get.close(6);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     color: AppColors.txtColor1,
        //   ),
        // ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            const Text(
              "Share with your friends",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "BalooBhai",
                  color: AppColors.txtColor1),
            ),
            SizedBox(
              child: Image.asset("assets/PNG/share.png"),
            ),
            const SizedBox(
              height: 25,
            ),

            // ElevatedButton(
            //     onPressed: () async {
            //       // // Get.to(const AgePage());
            //       String message =
            //           "Story Title: ${widget.shareData?.storyTitle}\nStory: \n${widget.shareData?.story}";
            //       // Share.share(message);
            //       // // Navigator.push(context, MaterialPageRoute(builder: (context) =>  Share()));
            //       Share.share(
            //           "GPT Stories For Kids\n \nStory: ${widget.shareData?.storyTitle}\n \nHere is a Story click on the link\n \n$shareStoryLink");
            //     },
            //     style: ButtonStyle(
            //         shadowColor:
            //             MaterialStatePropertyAll(AppColors.kBtnShadowColor),
            //         backgroundColor:
            //             const MaterialStatePropertyAll(AppColors.kBtnColor),
            //         shape: MaterialStateProperty.all(RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(15))),
            //         fixedSize:
            //             MaterialStateProperty.all(const Size(200, 50))),
            //     child: const SizedBox(
            //         height: 50,
            //         // width: MediaQuery.of(context).size.width/2,
            //         child: Center(
            //             child: Text("Share",
            //                 style: TextStyle(
            //                     color: AppColors.kBtnTxtColor,
            //                     fontWeight: FontWeight.bold,
            //                                                                                                fontSiz e: 18))))),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      onTap: () {
                        String message =
                            "Story Title: ${widget.shareData?.storyTitle}\nStory: \n${widget.shareData?.story}";
                        getShare();
                        Share.share(
                            "GPT Stories For Kids\n \nStory: ${MyRepo.currentStory.storyTitle}\n \nHere is a Story click on the link\n \n$shareStoryLink");

                      },
                      color: AppColors.kBtnColor,
                      // height: MediaQuery.of(context).size.height*0.17,
                      width: MediaQuery.of(context).size.height * 0.2,
                      text: "Share",
                      textSize: 20.0,
                      txtcolor: AppColors.kBtnTxtColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      onTap: () {
                        MyRepo.musicMuted.value == false? MyRepo.assetsAudioPlayer.play():null;

                        Get.close(5);

                      },
                      color: AppColors.emoji2Color,
                      // height: MediaQuery.of(context).size.height*0.17,
                      width: MediaQuery.of(context).size.height * 0.2,
                      text: "No Thanks",
                      textSize: 20.0,
                      txtcolor: AppColors.kBtnTxtColor,
                    ),
                  ),
                ),
              ],
            ),

            // ElevatedButton(
            //     onPressed: () {
            //       // Navigator.push(context, MaterialPageRoute(builder: (context) => StoryCategoryPage()));
            //       Get.close(4);
            //     },
            //     style: ButtonStyle(
            //         shadowColor:
            //             MaterialStatePropertyAll(AppColors.kBtnShadowColor),
            //         backgroundColor:
            //             const MaterialStatePropertyAll(AppColors.kBtnColor),
            //         shape: MaterialStateProperty.all(RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(15))),
            //         fixedSize:
            //             MaterialStateProperty.all(const Size(200, 50))),
            //     child: const SizedBox(
            //         height: 50,
            //         // width: MediaQuery.of(context).size.width/2,
            //         child: Center(
            //             child: Text("More Stories",
            //                 style: TextStyle(
            //                     color: AppColors.kBtnTxtColor,
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 18))))),
          ],
        ),
      ),
    );
  }
}
