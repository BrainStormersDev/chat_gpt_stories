import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_gpt_stories/utils/MyRepo.dart';
import 'package:chat_gpt_stories/view/Pages/rate_us_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:text_to_speech/text_to_speech.dart';
import '../../common/headers.dart';
import '../../controllers/chat_image_controller.dart';
import '../../controllers/chat_text_controller.dart';
import '../../model/StoryCategoryModels.dart';
import '../../utils/app_color.dart';

class StoryViewPage extends StatefulWidget {
  final StoryCatData data;
  const StoryViewPage({Key? key, required this.data}) : super(key: key);

  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  TextToSpeech tts = TextToSpeech();
  // ChatImageController controllerImage= Get.put(ChatImageController());
  ChatTextController controllerText= Get.put(ChatTextController());
  String mystring ='';

  var styleOne = const TextStyle(color: Colors.black87, fontSize: 21);

  var styleTwo = const TextStyle(
      color: Colors.black87, fontWeight: FontWeight.w800, fontSize: 24);

  @override
  void initState() {
    // TODO: implement initState
    _speak(controllerText.getStoryModels.value.data!.story);
    // _speak(controllerText.messages[0].text);




    super.initState();
  }
  @override
  void deactivate() {
    // TODO: implement deactivate

    _stop();
    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kScreenColor,

      body: SafeArea(
        child:  /*(controllerText.state.value == ApiState.loading) ?const CircularProgressIndicator() : */
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, color: AppColors.txtColor1,), ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 27,
                              child: Image.asset("assets/PNG/gridIcon.png")),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                          const Text(
                            "Story ",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                fontFamily: "BalooBhai",
                                color: AppColors.kBtnColor),
                          ),
                          const Text(
                            "By GPT",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                fontFamily: "BalooBhai",
                                color: AppColors.txtColor1),
                          ),
                        ],
                      ),
                    ),
                    Row(
                     children: [
                       Image.asset("assets/PNG/bellIcon.png",width: 20,),
                       IconButton(
                           onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => const RateUsPage()));
                           },
                           icon: const Icon(CupertinoIcons.star, color: AppColors.kBtnColor,))
                     ],
                   )

                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10,left: 15,right: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              // height: MediaQuery.of(context).size.height * 0.1,
                              // width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: AppColors.kBtnColor, width: 1)
                              ),
                              child:  Padding(
                                padding: EdgeInsets.only(left: 8.0, top: 4, bottom: 4, right: 8),
                                child: Text(
                                  "Story of ${widget.data.title}",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "BalooBhai",
                                      color: AppColors.kBtnColor),
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(
                          //     height: MediaQuery.of(context).size.height * 0.12,
                          //     child: Image.asset("assets/PNG/loin.png")),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 220,
                        // width: double.infinity,
                        child:CachedNetworkImage(
                          // imageUrl: kDemoImage,
                          imageUrl: ""??controllerText.getStoryModels.value.data!.images![0].imageUrl! ,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              SizedBox(
                                  width: double.infinity,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.withOpacity(.3),
                                    highlightColor: Colors.grey,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4)),
                                    ),
                                  )),
                          errorWidget: (context, url, error) => Container(
                            height: 200,
                            width: 200,
                            decoration:  BoxDecoration(
                              image:DecorationImage(
                                image: NetworkImage(
                                    widget.data.imageUrl),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(bottom: 10,left: 15,right: 15),
              child: SingleChildScrollView(
                reverse: true,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [





                      Stack(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                controllerText.getStoryModels.value.data!.story!,
                                                        style: TextStyle(color: AppColors.kWhite, fontSize: 25,fontWeight: FontWeight.bold),
                                                        textAlign: TextAlign.start,
                                                      ),

                          DefaultTextStyle(
                            style: const TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Bobbers',
                                color:  AppColors.kPrimary
                            ),
                            child: AnimatedTextKit(
                              animatedTexts: [

                                TyperAnimatedText(controllerText.getStoryModels.value.data!.story!,
                                  textStyle: TextStyle(color:AppColors.txtColor2, fontSize: 25,fontWeight: FontWeight.bold),
                                  speed: const Duration(milliseconds: 70),
                                ),

                              ],
                              onTap: () {
                                print("Tap Event");
                              },
                              stopPauseOnTap: true,
                              totalRepeatCount: 1,

                            ),
                          ),
                          // Card(
                          //   child: CachedNetworkImage(
                          //     imageUrl: controllerImage.images.isEmpty?"":controllerImage.images[3].url,
                          //     fit: BoxFit.cover,
                          //     progressIndicatorBuilder: (context, url, downloadProgress) =>
                          //         SizedBox(
                          //             height: 150,
                          //             width: 150,
                          //             child: Shimmer.fromColors(
                          //               baseColor: Colors.grey.withOpacity(.3),
                          //               highlightColor: Colors.grey,
                          //               child: Container(
                          //                 height: 220,
                          //                 width: 130,
                          //                 decoration: BoxDecoration(
                          //                     color: Colors.white,
                          //                     borderRadius: BorderRadius.circular(4)),
                          //               ),
                          //             )),
                          //     errorWidget: (context, url, error) => const Icon(Icons.error),
                          //   ),
                          // ),
                        ],
                      ),



                  ],
                ),
              ),
            ),
          )

          ],
        ),
      ),
    );
  }

  _speak(text) {
    double rate = 0.8;
    tts.setRate(rate);
    String language = 'en-US';
    tts.setLanguage(language);
    tts.speak(text);
  }

  _stop() {
    tts.stop();
  }
}
