import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gpt_chat_stories/common/headers.dart';
import 'package:gpt_chat_stories/utils/my_indicator.dart';
import '../../controllers/CreateStoryController.dart';
import '../../utils/MyRepo.dart';
import '../../view/Pages/rate_us_page.dart';
import '../../view/Widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_color.dart';
import '../Widgets/constWidgets.dart';
import '../Widgets/settingsDialog.dart';

class StoryFinish extends StatefulWidget {
  const StoryFinish({super.key});

  @override
  State<StoryFinish> createState() => _StoryFinishState();
}

class _StoryFinishState extends State<StoryFinish> {
  CreateStoryController controller = Get.put(CreateStoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kScreenColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.kBackgroundTopColor,
        title: storyByGptWidget(context),
        centerTitle: true,
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

        leading: IconButton(
          onPressed: () {
            MyRepo.musicMuted.value == false
                ? MyRepo.assetsAudioPlayer.play()
                : null;
            Get.close(1);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.txtColor1,
          ),

        ),
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
        child: WillPopScope(
          onWillPop: () async {
            MyRepo.musicMuted.value == false
                ? MyRepo.assetsAudioPlayer.play()
                : null;
            Get.close(1);
            return false;
          },
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(
                      "assets/PNG/lion.png",
                      height: 200,
                      // width: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      onTap: () async {
                        Get.close(3);
                      },
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: MediaQuery.of(context).size.height * 0.45,
                      radius: 5.0,
                      color: AppColors.kBtnColor,
                      text: "Do you want to  hear another story",
                      textSize: 20.0,
                      txtcolor: AppColors.kBtnTxtColor,
                    ),
                  ),
                  controller.state.value == ApiState.loading
                      ? myIndicator()
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomButton(
                            onTap: () {
                              if (controller.isNewStory.value) {
                                controller.saveStory();
                              } else {
                                Navigator.push(
                                    Get.context!,
                                    MaterialPageRoute(
                                        builder: (context) => RateUsPage()));
                              }
                            },
                            height: MediaQuery.of(context).size.height * 0.17,
                            width: MediaQuery.of(context).size.height * 0.45,
                            text: controller.isNewStory.value
                                ? "Save this story"
                                : "It is Enough for today",
                            textSize: 20.0,
                            txtcolor: AppColors.kBtnColor,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
