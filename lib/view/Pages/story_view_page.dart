import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gpt_chat_stories/utils/mySnackBar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../controllers/musicController.dart';
import '../../model/storyCatListModel.dart';
import '../../view/Pages/rate_us_page.dart';
import '../../view/Pages/storyfinish_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import '../../controllers/getStoriesController.dart';
import '../../utils/MyRepo.dart';
import '../../utils/app_color.dart';

class StoryViewPage extends StatefulWidget {
  List<String>? images;
  String story;
  String storyTitle;
  // SelectedStoryData? data;
  String? catName;
  bool isNewStory;
  StoryViewPage({Key? key,this.isNewStory=false, this.catName,this.story="", this.storyTitle="" , this.images}) : super(key: key);
  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}
enum TtsState { playing, stopped, paused, continued }
class _StoryViewPageState extends State<StoryViewPage> with TickerProviderStateMixin, WidgetsBindingObserver{
  FlutterTts tt = FlutterTts();
  StoriesController controllerText = Get.put(StoriesController());

  final ScrollController _scrollController = ScrollController();
  List<String> image = [];
  int activeIndex = 0;
  RxBool isPaused = false.obs;
  RxBool textStop = false.obs;
  bool isPlayNext = false;
  late FlutterTts flutterTts;
  var styleOne = const TextStyle(color: Colors.black87, fontSize: 21);
  var styleTwo = const TextStyle( color: Colors.black87, fontWeight: FontWeight.w800, fontSize: 24);
  String _text = '';
  int _currentWordIndex = 0;
  List<String> _words = [];
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        if (!isPaused.value) {
          textStop.value = true;
          _playTextWithDelay();
          tt.pause();
        }
        break;
      case AppLifecycleState.resumed:
        if (!isPaused.value) {
          textStop.value = false;
          _playTextWithDelay();
          _ttsInit();
        }
        break;
      default:
        break;
    }
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (ModalRoute.of(context)?.isCurrent == true) {
    }
  }
  Future<void> _playTextWithDelay({bool fromStart=false}) async {
    const Duration wordDelay =  Duration(milliseconds: 310); // Change this value
    Duration totalElapsedTime = const Duration(); // Track total elapsed time
    Future<void> playWord(int index) async {
      if(fromStart==true)
      {
        index=0;
        _currentWordIndex=0;
        // print("index: ${index} ${_currentWordIndex}");

        fromStart=false;
      }

      await Future.delayed(wordDelay);
      if (mounted && !textStop.value) {
        setState(() {
          _currentWordIndex = index;
          // print("index is: ${index}");
        });
        totalElapsedTime = Duration(); // Reset the total elapsed time
        if (index <= _words.length - 1) {
          // print("words length: ${_words.length}");
          if (_words[_currentWordIndex].endsWith('.') ||
              _words[_currentWordIndex].endsWith(',')) {
            await Future.delayed(const Duration(milliseconds: 290));
            // print(".");
          }
          if (_words[_currentWordIndex].startsWith('.\n')) {
            print('break');
            await Future.delayed(const Duration(milliseconds: 290));

          }

          await playWord(_currentWordIndex + 1);
        }
      }
    }
    await playWord(_currentWordIndex);
  }
  StoriesController storiesController = Get.put(StoriesController());

  @override
  void initState() {

    WidgetsBinding.instance.addObserver(this);
    MyRepo.isStoryReading.value=true;
    print(widget.story.toString());
    _text=widget.story.toString();
    _words = _text.split(' ');
    _playTextWithDelay();
    super.didChangeDependencies();

      BackgroundMusicManager().pauseMusic();


    _ttsInit();
    super.initState();
  }
  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    MyRepo.isStoryReading.value=false;
    if(MyRepo.musicMuted.value == false)
    {
      BackgroundMusicManager().resumeMusic();
    }
    super.dispose();
    tt.stop();
  }
  @override
  void deactivate() {
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
    // print("current index: ${_currentWordIndex}");
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];
    image.clear();
    if (widget.images!=null && widget.images!.isNotEmpty) {
      for (int i = 0; i < widget.images!.length; i++) {
        image.add(widget.images![i].toString());
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
        child:
        CachedNetworkImage(
          imageUrl:item,
          fit: BoxFit.cover, width: 1000.0,
          progressIndicatorBuilder:
              (context, url,
              downloadProgress) =>
              SizedBox(
                  width:
                  double.infinity,
                  child: Shimmer
                      .fromColors(
                    baseColor: Colors
                        .grey
                        .withOpacity(
                        .3),
                    highlightColor:
                    Colors.grey,
                    child: Container(
                      width: double
                          .infinity,
                      decoration: BoxDecoration(
                          color: Colors
                              .white,
                          borderRadius:
                          BorderRadius
                              .circular(
                              4)),
                    ),
                  )),
          errorWidget:
              (context, url, error) =>
              Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/PNG/img_4.png"
                      // "${widget.data.images!.first.imageUrl}"
                      // widget.data.imageUrl
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
        ),


      ),
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
                      onPressed: () async {
                        try {
                          MyRepo.isStoryReading.value=false;
                          if(MyRepo.musicMuted.value == false )
                          {
                            BackgroundMusicManager().resumeMusic();
                          }
                        } catch (t) {
                          //mp3 unreachable
                        }
                        // Get.back();
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
                                  "Story of ${widget.storyTitle}",
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

                      imageSliders != null
                          ? Padding(
                        padding:
                        const EdgeInsets.only(left: 15, right: 15),
                        child: CarouselSlider(
                          options: CarouselOptions(
                              scrollPhysics:
                              const BouncingScrollPhysics(),
                              viewportFraction: 1,
                              aspectRatio: 1.5,
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
                            ),

                            // AnimatedTextKit(
                            //   animatedTexts: [
                            //     TyperAnimatedText(
                            //       widget.data.story!,
                            //       textStyle: TextStyle(
                            //           color: AppColors.txtColor2,
                            //           fontSize: 25,
                            //           fontWeight: FontWeight.bold),
                            //       speed: Duration(milliseconds: 65),
                            //     ),
                            //   ],
                            //
                            //     pause: Duration(milliseconds: 80),
                            //   onTap: () {
                            //     print("Tap Event");
                            //   },
                            //
                            //   stopPauseOnTap: false,
                            //   totalRepeatCount: 1,
                            //   // isRepeatingAnimation: isAnimationRunning,
                            //   key: ValueKey<bool>(isAnimationRunning),
                            // ),
                          ),

                        ],
                      ), SizedBox(height: 60,),
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
            if(widget.isNewStory==false)
            IconButton(

                onPressed:
                    () async {
                  int newIndex = controllerText
                      .storyCategoryListModels.value.data!
                      .indexWhere((element) =>
                  element.storyTitle ==
                      widget.storyTitle
                  );
                  if (newIndex == 0) {

                    MySnackBar.snackBarPrimary(title: "Info", message: "Start of the list");

                    // tt.stop();
                    // _ttsInit();

                  }
                  else {
                    setState(() {
                      MyRepo.currentStory.value=DataList();

                      MyRepo.currentStory.value.storyTitle=controllerText.storyCategoryListModels.value.data![newIndex-1].storyTitle;
                      Navigator.pop(context);
                    });
                    await  controllerText.getStory( storyId: controllerText
                        .storyCategoryListModels
                        .value.data![newIndex-1].id.toString());

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
                  isPaused.value = !isPaused.value;
                  textStop.value= isPaused.value;
                  _playTextWithDelay();
                  if(isPaused.value)
                  {
                    tt.pause();
                  }
                  else
                  {
                    _ttsInit();
                  }
                });
              },
              child: isPaused.value
                  ? const Icon(Icons.play_arrow)
                  : const Icon(Icons.pause),
            ),
            if(widget.isNewStory==false)
            IconButton(
                onPressed:
                    () async {
                  int newIndex = controllerText
                      .storyCategoryListModels.value.data!
                      .indexWhere((element) =>
                  element.storyTitle ==
                      widget.storyTitle
                  );
                  if (newIndex == controllerText.storyCategoryListModels.value.data!.length-1) {

                    MySnackBar.snackBarPrimary(title: "Info", message: "End of the list");

                    // tt.stop();
                    // _ttsInit();

                  }
                  else {
                    setState(() {
                      MyRepo.currentStory.value=DataList();

                      MyRepo.currentStory.value.storyTitle=controllerText.storyCategoryListModels.value.data![newIndex+1].storyTitle;
                      Navigator.pop(context);
                    });
                    await  controllerText.getStory( storyId: controllerText
                        .storyCategoryListModels
                        .value.data![newIndex+1].id.toString());

                  }


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
    WakelockPlus.enable();
    // print(widget.story!.toString());
    await tt.speak(widget.story!.toString());
    tt.setProgressHandler((String text, int startOffset, int endOffset, String word) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );});
    tt.setContinueHandler((){
      setState(() {
        ttsState = TtsState.continued;
      });});
    tt.setCompletionHandler(() {

      MyRepo.isStoryReading.value=false;
      if(MyRepo.musicMuted.value == false )
      {
        BackgroundMusicManager().resumeMusic();
      }
      Navigator.of(Get.context!).push(
          MaterialPageRoute(
              builder: (context) =>
                  StoryFinish()));

      WakelockPlus.disable();
      print('Speech completed');
    });
  }
}