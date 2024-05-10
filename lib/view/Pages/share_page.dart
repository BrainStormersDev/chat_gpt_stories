import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/storyCatListModel.dart';
import '../../utils/dynamic_link_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../utils/MyRepo.dart';
import '../../utils/app_color.dart';
import '../Widgets/constWidgets.dart';
import '../Widgets/customButton.dart';
import '../Widgets/settingsDialog.dart';

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
        MyRepo.storyCat.toString(), MyRepo.currentStory.value.storyTitle.toString());
    print("======shareStoryLink== $shareStoryLink");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundTopColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            MyRepo.musicMuted.value == false
                ? MyRepo.assetsAudioPlayer.play()
                : null;
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.txtColor1,
          ),

        ),

        actions: [
          IconButton(
              onPressed: () {
                showCustomSettingDialog(context);

              },
              icon:  Icon(
                FontAwesomeIcons.gear,
                color: AppColors.kBtnColor,
              ))
        ],

        automaticallyImplyLeading: false,
        elevation: 0,
        title: storyByGptWidget(context),
        centerTitle: true,
        backgroundColor: AppColors.kScreenColor,
      ),
      body: Container(

        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDDFE9),
              // Colors.red,
              // Colors.orange,
              Color(0xFFB6E7F1),

              // Colors.green,
              // Colors.blue,
              // Colors.indigo,
              // Colors.purple,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
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
                              "GPT Stories For Kids\n \nStory: ${MyRepo.currentStory.value.storyTitle}\n \nHere is a Story click on the link\n \n$shareStoryLink");

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

            ],
          ),
        ),
      ),
    );
  }
}
