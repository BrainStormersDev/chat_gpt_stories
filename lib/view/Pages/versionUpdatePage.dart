import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/versions.dart';
import '../../utils/app_color.dart';

class VersionUpdatePage extends StatefulWidget {
  const VersionUpdatePage({super.key});

  @override
  State<VersionUpdatePage> createState() => _VersionUpdatePageState();
}

class _VersionUpdatePageState extends State<VersionUpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kSplashColor,
      body: Stack(
        children: [
          Positioned(
            top: 90,
            left: 30,
            right: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Story ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "BalooBhai", color: AppColors.kBtnColor),),
                    Text("By GPT", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "BalooBhai", color: AppColors.txtColor1),),
                  ],
                ),
                const SizedBox(height: 10,),
                DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Bobbers',
                      color:  AppColors.txtColor1
                  ),
                  child: AnimatedTextKit(

                    animatedTexts: [

                      TyperAnimatedText("Unlock enchanting new features \n with the latest update!",
                        // TyperAnimatedText(controllerText.messages[0].text,
                        textStyle: TextStyle(color: AppColors.txtColor1, fontSize: 15),

                        speed: const Duration(milliseconds: 70),

                      ),
                    ],
                    onTap: () {
                    },
                    stopPauseOnTap: true,
                    totalRepeatCount: 1,

                  ),
                ),
                // const Text("Welcome to new platform of \n Story Telling. Let’s Begin",
                //   style: TextStyle(color: AppColors.txtColor1, fontSize: 15), textAlign: TextAlign.center,),
              ],
            ),),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height/2.3,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(150), topRight: Radius.circular(150))
                ),
              )),
          Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              // height: MediaQuery.of(context).size.height/1.5,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/PNG/loin.png", scale: 1.2,)),
          ),
          ///Button
          Positioned(
            left: 40,
            right: 40,
            bottom: 40,
            child: Column(
              children: [

                ElevatedButton(
                    onPressed:
                        () async {
                      ///Start
                          try {
                            launch(

                                playStoreUrl

                            );
                          }
                          on PlatformException {
                            launch(
                                playStoreUrl


                            );
                          }
                          finally {
                            launch(
                                playStoreUrl

                            );
                          }


                      ///End
                    },
                    style: ButtonStyle(
                        shadowColor:  MaterialStatePropertyAll(AppColors.kBtnShadowColor),
                        backgroundColor:  MaterialStatePropertyAll(AppColors.kBtnColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
                    ),
                    child: const SizedBox(
                        height: 50,
                        // width: MediaQuery.of(context).size.width/2,
                        child: Center(
                            child: Text("Update Available",
                                style: TextStyle(color: AppColors.kBtnTxtColor, fontWeight: FontWeight.bold, fontSize: 18))))),
              ],
            ),
          ),

        ],
      ),

    );
  }
}
