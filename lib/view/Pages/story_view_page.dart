import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_gpt_stories/utils/MyRepo.dart';
import 'package:chat_gpt_stories/view/Pages/rate_us_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';
import '../../common/headers.dart';
import '../../controllers/chat_image_controller.dart';
import '../../controllers/chat_text_controller.dart';
import '../../model/StoryCategoryModels.dart';
import '../../model/storyCatListModel.dart';
import '../../utils/app_color.dart';
import 'share_page.dart';

class StoryViewPage extends StatefulWidget {
  final DataList data;
  // final StoryCatData data;
  const StoryViewPage({Key? key, required this.data,}) : super(key: key);

  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  TextToSpeech tts = TextToSpeech();
  final SpeechToText _speech = SpeechToText();
  // ChatImageController controllerImage= Get.put(ChatImageController());
  // ChatTextController controllerText= Get.put(ChatTextController());
  String mystring ='';

  var styleOne = const TextStyle(color: Colors.black87, fontSize: 21);

  var styleTwo = const TextStyle(
      color: Colors.black87, fontWeight: FontWeight.w800, fontSize: 24);

  final ScrollController _scrollController = ScrollController();

  bool _isListening = true;

  @override
  initState()  {
    // TODO: implement initState
    // print(controllerText.storyCategoryListModels.value.data!.first.story!+"=====Story========");
    String character = widget.data.story.toString();
    // String character = controllerText.storyCategoryListModels.value.data!.first.story!;

    // _listen();

    _speak(character);



    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.position.maxScrollExtent == _scrollController.offset
          ? _scrollController.jumpTo(_scrollController.position.minScrollExtent)
          : _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration:  const Duration(milliseconds: 100000), curve: Curves.linear);
    });

    super.initState();
  }

  void _listen() async {
    print("_listen call");
    if (!_isListening) {
      print("_listen initialize");
      bool available = await _speech.initialize(
        onStatus: (status) => print('onStatus: $status'),
        onError: (error) => print('onError: $error'),
      );
      if (available) {
        print("_listen available");
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) => setState(() {
            print("_listen call");
            widget.data.story = result.recognizedWords;
            _speak(result.recognizedWords);
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
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
                                  "Story of ${widget.data.storyTitle}",
                                  // "Story of ${widget.data.title}",
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
                      const SizedBox(height: 10,),
                      // Container(
                      //   height: 220,
                      //   // width: double.infinity,
                      //   child:CachedNetworkImage(
                      //     // imageUrl: kDemoImage,
                      //     imageUrl: "${widget.data.images!.first.imageUrl}" ,
                      //     // imageUrl: ""??controllerText.getStoryModels.value.data!.images![0].imageUrl! ,
                      //     fit: BoxFit.fill,
                      //     progressIndicatorBuilder: (context, url, downloadProgress) =>
                      //         SizedBox(
                      //             width: double.infinity,
                      //             child: Shimmer.fromColors(
                      //               baseColor: Colors.grey.withOpacity(.3),
                      //               highlightColor: Colors.grey,
                      //               child: Container(
                      //                 width: double.infinity,
                      //                 decoration: BoxDecoration(
                      //                     color: Colors.white,
                      //                     borderRadius: BorderRadius.circular(4)),
                      //               ),
                      //             )),
                      //     errorWidget: (context, url, error) => Container(
                      //       height: 200,
                      //       width: 200,
                      //       decoration:  BoxDecoration(
                      //         image:DecorationImage(
                      //           image: NetworkImage(
                      //               "${widget.data.images![0]}"
                      //               // widget.data.imageUrl
                      //           ),
                      //           fit: BoxFit.fill,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
                controller: _scrollController,
                // reverse: true,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                      Stack(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            widget.data.story.toString(),
                            // controllerText.storyCategoryListModels.value.data!.first.story!,
                           style: const TextStyle(color: AppColors.kWhite, fontSize: 25,fontWeight: FontWeight.bold),
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
                                TyperAnimatedText(
                                  widget.data.story.toString(),
                                  // controllerText.storyCategoryListModels.value.data!.first.story!,
                                  textStyle: TextStyle(color:AppColors.txtColor2, fontSize: 25,fontWeight: FontWeight.bold),
                                  speed: const Duration(milliseconds: 95),

                                ),

                              ],
                              onTap: () {
                                print("Tap Event");
                              },
                              stopPauseOnTap: true,
                              totalRepeatCount: 1,
                              onFinished: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> const SharePage()));
                              },

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



  _speak(text) async {
    double rate = 0.5;
    tts.setRate(rate);
    String language = 'en-US';
    tts.setLanguage(language);
    // tts.setPitch(3);
    tts.speak(await text);
    // .asStream().listen((event) {})
    // .whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context)=> const SharePage())))
  }

  _stop() {
    tts.stop();
  }
}
