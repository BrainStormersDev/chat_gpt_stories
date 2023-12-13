import 'dart:async';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import '../../view/Pages/rate_us_page.dart';
import '../../view/Pages/storyfinish_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import '../../controllers/chat_text_controller.dart';
import '../../model/storyCatListModel.dart';
import '../../utils/MyRepo.dart';
import '../../utils/app_color.dart';

class StoryViewPage extends StatefulWidget {
  DataList data;
  final String? catName;
  StoryViewPage({Key? key, required this.data, this.catName}) : super(key: key);
  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}
enum TtsState { playing, stopped, paused, continued }
class _StoryViewPageState extends State<StoryViewPage> {
  FlutterTts tt = FlutterTts();
  RxList<String> listTxt = <String>[].obs;
  ChatTextController controllerText = Get.put(ChatTextController());
  final ScrollController _scrollController = ScrollController();
  List<String> image = [];
  int activeIndex = 0;
  bool isPaused = false;
  bool isPlayNext = false;
  late FlutterTts flutterTts;
  var styleOne = const TextStyle(color: Colors.black87, fontSize: 21);
  var styleTwo = const TextStyle( color: Colors.black87, fontWeight: FontWeight.w800, fontSize: 24);
  String _text = '';
      int _currentWordIndex = 0;
  List<String> _words = [];

  void _playTextWithDelay() {
    const Duration wordDelay = const Duration(milliseconds: 300); // Change this value
    Duration totalElapsedTime = Duration(); // Track total elapsed time

    Future<void> playWord(int index) async {
      await Future.delayed(wordDelay);
      if (mounted && !isPaused) {
        setState(() {
          _currentWordIndex = index;
        });
        totalElapsedTime = Duration(); // Reset the total elapsed time
        if (index < _words.length - 1) {
          await playWord(index + 1);
        }
      }
    }
    playWord(_currentWordIndex);
  }
  @override
  void initState() {
    _text=widget.data.story.toString();
    _words = _text.split(' ');
    _playTextWithDelay();
    super.didChangeDependencies();
    _ttsInit();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    tt.stop();
  }
  @override
  void deactivate() {
    // TODO: implement deactivate

    // _stop();
    super.deactivate();
  }
  @override
  void didChangeDependencies() {
    try {
      for (var element in image) {
        precacheImage(NetworkImage(element.toString()), context);
      }
    } catch (e) {
      print("-------------------------------------------------");
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    String displayText = _words.take(_currentWordIndex).join(' ');
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];
    image.clear();
    if (widget.data.images!.isNotEmpty) {
      for (int i = 0; i < widget.data.images!.length; i++) {
        image.add(widget.data.images![i].imageUrl.toString());
      }
    } else {
      for (int i = 0; i < imgList.length; i++) {
        image.add(imgList[i].toString());
      }
    }
    final List<Widget> imageSliders = image
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Image.network(item, fit: BoxFit.cover, width: 1000.0)),
            ))
        .toList();
    return Scaffold(
      backgroundColor: AppColors.kScreenColor,
      body: SafeArea(
        child: Column(
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
                      onPressed: () {
                        // flutterTts.stop();
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.txtColor1,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 27,
                              child: Image.asset("assets/PNG/gridIcon.png")),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
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
                        Image.asset(
                          "assets/PNG/bellIcon.png",
                          width: 20,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RateUsPage()));
                            },
                            icon: const Icon(
                              CupertinoIcons.star,
                              color: AppColors.kBtnColor,
                            ))
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 15, right: 15),
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
                                  border: Border.all(
                                      color: AppColors.kBtnColor, width: 1)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 8.0, top: 4, bottom: 4, right: 8),
                                child: Text(
                                  "Story of ${widget.data.storyTitle}",
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
                      SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   height: 220,
                      //   // width: double.infinity,
                      //   child: CachedNetworkImage(
                      //     // imageUrl: kDemoImage,
                      //     imageUrl: "" ??
                      //         controllerText.storyCategoryListModels.value.data![0]
                      //             .images![0].imageUrl!,
                      //     fit: BoxFit.fill,
                      //     progressIndicatorBuilder:
                      //         (context, url, downloadProgress) => SizedBox(
                      //         width: double.infinity,
                      //         child: Shimmer.fromColors(
                      //           baseColor: Colors.grey.withOpacity(.3),
                      //           highlightColor: Colors.grey,
                      //           child: Container(
                      //             width: double.infinity,
                      //             decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius:
                      //                 BorderRadius.circular(4)),
                      //           ),
                      //         )),
                      //     errorWidget: (context, url, error) => Container(
                      //       height: 200,
                      //       width: 200,
                      //       decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //           image: NetworkImage(widget.data.images![0].imageUrl.toString()),
                      //           fit: BoxFit.fill,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),



                      imageSliders != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
                                    viewportFraction: 1,
                                    aspectRatio: 2.0,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                    autoPlay: true,
                                    onPageChanged:
                                        (index, CarouselPageChangedReason) {
                                      activeIndex = index;
                                    }),
                                items: imageSliders,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Bobbers',
                                color: AppColors.kPrimary),
                            child:
                            Text(
                              displayText,
                              style:
                              TextStyle(
                                          color: AppColors.txtColor2,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                              // TextStyle(fontSize: 18.0),
                              // textAlign: TextAlign.center,
                            ),

                            // AnimatedTextKit(
                            //   animatedTexts: [
                            //     TyperAnimatedText(
                            //       widget.data.story!,
                            //       textStyle: TextStyle(
                            //           color: AppColors.txtColor2,
                            //           fontSize: 25,
                            //           fontWeight: FontWeight.bold),
                            //       speed: Duration(milliseconds: 70),
                            //     ),
                            //   ],
                            //
                            //     pause: Duration(milliseconds: 70),
                            //   onTap: () {
                            //     print("Tap Event");
                            //   },
                            //   stopPauseOnTap: false,
                            //   totalRepeatCount: 1,
                            // ),
                          ),
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
      floatingActionButton: Container(
        // color: Colors.red,
        decoration: BoxDecoration(
            color: AppColors.kBlack.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.only(left: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: controllerText.storyCategoryListModels.value.data!
                            .indexWhere((element) =>
                 element.storyTitle == widget.data.storyTitle) ==
                        0
                    ? null
                    : () {
                        int newIndex = controllerText
                            .storyCategoryListModels.value.data!
                            .indexWhere((element) =>
                                element.storyTitle == widget.data.storyTitle);
logger.e(newIndex);
                        if (newIndex <
                            controllerText
                                .storyCategoryListModels.value.data!.length) {
                          widget.data = controllerText.storyCategoryListModels
                              .value.data![newIndex - 1];
                          MyRepo.currentStory = controllerText
                              .storyCategoryListModels
                              .value
                              .data![newIndex - 1];
                          _text=widget.data.story.toString();
                          _currentWordIndex = 0;
                          _words = [];
                          _words = _text.split(' ');
                          isPaused=false;
                          displayText = _words.take(_currentWordIndex).join(' ');
                          _playTextWithDelay();
                          tt.stop();
                          listTxt.clear();
                          _ttsInit();
                          setState(() {  logger.i(_text);});
                        }

                      },
                icon: const Icon(
                  Icons.skip_previous_rounded,
                  color: AppColors.kBtnColor,
                  size: 30,
                )),
            FloatingActionButton.small(
              backgroundColor: AppColors.kBtnColor,
              onPressed: () {
                setState(() {
                  isPaused = !isPaused;
                  _playTextWithDelay();
                 if(isPaused)
                   {
                     tt.pause();
                   }
                 else
                   {
                     _ttsInit();
                   }
                });
              },
              child: isPaused
                  ? const Icon(Icons.play_arrow)
                  : const Icon(Icons.pause),
            ),
            IconButton(
                onPressed: (controllerText.storyCategoryListModels.value.data!
                                .lastIndexWhere((element) =>
                                    element.storyTitle ==
                                    widget.data.storyTitle) ==
                            controllerText
                                .storyCategoryListModels.value.data!.length) ==
                        true
                    ? null
                    : () {
                        int newIndex = controllerText
                            .storyCategoryListModels.value.data!
                            .indexWhere((element) =>
                                element.storyTitle == widget.data.storyTitle);
                        setState(() {
                          if (newIndex ==
                              controllerText
                                  .storyCategoryListModels.value.data!.length) {
                            widget.data = controllerText
                                .storyCategoryListModels.value.data![newIndex];
                            MyRepo.currentStory = controllerText
                                .storyCategoryListModels.value.data![newIndex];
                            tt.stop();
                            listTxt.clear();
                            _ttsInit();
                          } else {
                            widget.data = controllerText.storyCategoryListModels
                                .value.data![newIndex + 1];
                            MyRepo.currentStory = controllerText
                                .storyCategoryListModels
                                .value
                                .data![newIndex + 1];
                            _text=widget.data.story.toString();
                            _currentWordIndex = 0;
                            _words = [];
                            _words = _text.split(' ');
                            isPaused=false;
                            displayText = _words.take(_currentWordIndex).join(' ');
                            _playTextWithDelay();
                            tt.stop();
                            listTxt.clear();
                            _ttsInit();
                          }
                        });
                      },

                // widget.nextStory,
                icon: const Icon(
                  Icons.skip_next_rounded,
                  color: AppColors.kBtnColor,
                  size: 30,
                )),
          ],
        ),
      ),
    );
  }
  TtsState ttsState = TtsState.stopped;
  _ttsInit() async {
    await tt.speak(widget.data.story.toString());
    tt.setProgressHandler((String text, int startOffset, int endOffset, String word) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
    tt.setContinueHandler((){
      setState(() {
        ttsState = TtsState.continued;
      });

    });
    tt.setCompletionHandler(() {
      // Do something when speech is complete
      Get.to(() => StoryFinish(data: widget.data, catName: widget.catName));
      print('Speech completed');
    });
  }
}
