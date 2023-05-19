import 'package:chat_gpt_stories/model/storyCatListModel.dart';
import 'package:chat_gpt_stories/utils/dynamic_link_provider.dart';
import 'package:chat_gpt_stories/view/Pages/share.dart';
import 'package:chat_gpt_stories/view/Pages/story_catList_page.dart';
import 'package:chat_gpt_stories/view/Pages/story_category_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';


import '../../utils/app_color.dart';

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
    shareStoryLink = await DynamicLinksProvider().createLink(widget.catName.toString(), widget.shareData!.storyTitle.toString());
    print("=====Dynamic Link == ${await DynamicLinksProvider().createLink(widget.catName.toString(), widget.shareData!.storyTitle.toString())}");
    print("======shareStoryLink== $shareStoryLink");
  }
  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20, top: 20, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 27,
                        child: Image.asset("assets/PNG/gridIcon.png")),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                    const Text(
                      "Story ",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "BalooBhai",
                          color: AppColors.kBtnColor),
                    ),
                    const Text(
                      "By GPT",
                      style: TextStyle(
                          fontSize: 30,
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

                const SizedBox(height: 25,),
                ElevatedButton(
                    onPressed: () async {
                      // // Get.to(const AgePage());
                      String message = "Story Title: ${widget.shareData?.storyTitle}\nStory: \n${widget.shareData?.story}";
                      // Share.share(message);
                      // // Navigator.push(context, MaterialPageRoute(builder: (context) =>  Share()));
                      Share.share("GPT Stories For Kids\n \nStory: ${widget.shareData?.storyTitle}\n \nHere is a Story click on the link\n \n$shareStoryLink");
                    },
                    style: ButtonStyle(
                        shadowColor:  MaterialStatePropertyAll(AppColors.kBtnShadowColor),
                        backgroundColor: const MaterialStatePropertyAll(AppColors.kBtnColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                        fixedSize: MaterialStateProperty.all(const Size(200, 50))
                    ),
                    child: const SizedBox(
                        height: 50,
                        // width: MediaQuery.of(context).size.width/2,
                        child: Center(
                            child: Text("Share",
                                style: TextStyle(color: AppColors.kBtnTxtColor, fontWeight: FontWeight.bold, fontSize: 18))))),
                const SizedBox(height: 25,),
                ElevatedButton(
                    onPressed: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => StoryCategoryPage()));
                      Get.close(4);
                    },
                    style: ButtonStyle(
                        shadowColor:  MaterialStatePropertyAll(AppColors.kBtnShadowColor),
                        backgroundColor: const MaterialStatePropertyAll(AppColors.kBtnColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                        fixedSize: MaterialStateProperty.all(const Size(200, 50))
                    ),
                    child: const SizedBox(
                        height: 50,
                        // width: MediaQuery.of(context).size.width/2,
                        child: Center(
                            child: Text("More Stories",
                                style: TextStyle(color: AppColors.kBtnTxtColor, fontWeight: FontWeight.bold, fontSize: 18))))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
