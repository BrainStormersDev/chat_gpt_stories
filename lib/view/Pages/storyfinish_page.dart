import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_stories/view/Pages/rate_us_page.dart';
import 'package:kids_stories/view/Pages/story_category_page.dart';
import '../../model/storyCatListModel.dart';
import '../../utils/MyRepo.dart';
import '../../utils/app_color.dart';
import '../Widgets/constWidgets.dart';
import '../Widgets/customButton.dart';
import '../Widgets/settingsDialog.dart';

class StoryFinish extends StatefulWidget {
  final DataList data;
  final String? catName;
   StoryFinish({required this.data, this.catName});

  @override
  State<StoryFinish> createState() => _StoryFinishState();
}

class _StoryFinishState extends State<StoryFinish> {
  @override
  void initState() {
    MyRepo.musicMuted.value == false? MyRepo.assetsAudioPlayer.play():null;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kScreenColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.kScreenColor,
        title: storyByGptWidget(context),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            MyRepo.musicMuted.value == false? MyRepo.assetsAudioPlayer.play():null;
            Get.close(3);
            Get.to(StoryCategoryPage());
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.txtColor1,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                print("=====");
                showCustomSettingDialog(context);

                // AssetsAudioPlayer.newPlayer().open(
                //   Audio(kWelcomeSound),
                //   autoStart: true,
                //   showNotification: true,
                // );
                // AssetsAudioPlayer.newPlayer().open(
                //   Audio("assets/audio/s_1.mp3"),
                //   // Audio("assets/audio/In 5 seconds.mp3"),
                //   autoStart: true,
                //   showNotification: true,
                // );


                //
                // await MyRepo.assetsAudioPlayer.open(
                //     Audio("assets/audio/s_1.mp3"),
                //     // Playlist(audios: [
                //     //   Audio.network(
                //     //       "http://story-telling.eduverse.uk/public/s_1.mp3"),
                //     // ]),
                //     loopMode: LoopMode.playlist);

                // Get.to(const Settings());

              },
              icon: const Icon(
                FontAwesomeIcons.gear,
                color: AppColors.kPrimary,
              ))],
      ),
      body: WillPopScope(
        onWillPop: () async{
          MyRepo.musicMuted.value == false? MyRepo.assetsAudioPlayer.play():null;
          Get.close(3);
          Get.to(StoryCategoryPage());
          return false;
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(
                      "assets/PNG/lion.png",
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      onTap:() async {
                        MyRepo.musicMuted.value == false? MyRepo.assetsAudioPlayer.play():null;
                        Get.close(5);
                        Get.to(StoryCategoryPage());},
                      height: MediaQuery.of(context).size.height*0.17,
                      width: MediaQuery.of(context).size.height * 0.45,
                      radius: 5.0,
                      color: AppColors.kBtnColor,
                      text: "Do you want to  hear another story",
                      textSize: 20.0,
                      txtcolor: AppColors.kBtnTxtColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                 RateUsPage()));
                        },
                      height: MediaQuery.of(context).size.height*0.17,
                      width: MediaQuery.of(context).size.height * 0.45,
                      text: "It is Enough for today",
                      textSize: 20.0,
                      txtcolor: AppColors.kBtnColor,
                    ),
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
