import '../../controllers/musicController.dart';
import '../../utils/MyRepo.dart';
import '../../view/Pages/rate_us_page.dart';
import '../../view/Widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../utils/app_color.dart';
import '../Widgets/constWidgets.dart';

class StoryFinish extends StatefulWidget {
  const StoryFinish({super.key});

  @override
  State<StoryFinish> createState() => _StoryFinishState();
}

class _StoryFinishState extends State<StoryFinish> {
  @override
  Widget  build(BuildContext context) {
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
            Get.close(2);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.txtColor1,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async{
          MyRepo.musicMuted.value == false? MyRepo.assetsAudioPlayer.play():null;
          Get.close(2);
          return false;
        },
        child: SafeArea(
          child: Padding(
            padding:
            const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 10),
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
                        if(MyRepo.musicMuted.value == false )
                        {
                          setState(() {

                          });
                          BackgroundMusicManager().resumeMusic();
                        }
                        Get.close(3);
                      },
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
                        if(MyRepo.musicMuted.value == false )
                        {
                          BackgroundMusicManager().resumeMusic();
                        }
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
