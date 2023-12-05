import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_gpt_stories/utils/MyRepo.dart';
import 'package:chat_gpt_stories/view/Pages/rate_us_page.dart';
import 'package:chat_gpt_stories/view/Pages/storyfinish_page.dart';
import 'package:chat_gpt_stories/view/Widgets/scrolling_Text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../common/headers.dart';
import '../../controllers/chat_image_controller.dart';
import '../../controllers/chat_text_controller.dart';
import '../../model/StoryCategoryModels.dart';
import '../../model/storyCatListModel.dart';
import '../../utils/app_color.dart';
import 'share_page.dart';

class StoryViewPage extends StatefulWidget {
    DataList data;
  final String? catName;
  // final StoryCatData data;
   StoryViewPage({Key? key, required this.data, this.catName})
      : super(key: key);

  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}
enum TtsState { playing, stopped, paused, continued }

class _StoryViewPageState extends State<StoryViewPage> {
  ChatTextController controllerText = Get.put(ChatTextController());
  // ChatImageController controllerImage= Get.put(ChatImageController());
  // ChatTextController controllerText= Get.put(ChatTextController());
  String mystring = '';
  var styleOne = const TextStyle(color: Colors.black87, fontSize: 21);
  var styleTwo = const TextStyle(
      color: Colors.black87, fontWeight: FontWeight.w800, fontSize: 24);

  final ScrollController _scrollController = ScrollController();

  int activeIndex = 0;
  FlutterTts tts = FlutterTts();
  RxString nTxt = "".obs;
  RxList<String> listTxt = <String>[].obs;
  List<String> widgetTxt = [];
  List<String> image = [];
  bool isPaused = false;
  bool isPlayNext = false;

  @override
  void initState() {
    super.initState();
    _ttsInit();
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
  void dispose() {
    // TODO: implement dispose
    _stop();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    _stop();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];
    image.clear();

    // (widget.data.images!.length != null || widget.data.images!.length != [])
    //     ? () {
    //         for (int i = 0; i < widget.data.images!.length; i++) {
    //           image.add(widget.data.images![i].toString());
    //         }
    //       }
    //     : () {
    for (int i = 0; i < imgList.length; i++) {
      image.add(imgList[i].toString());
    }
    // };

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
        child: /*(controllerText.state.value == ApiState.loading) ?const CircularProgressIndicator() : */
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
                      onPressed: () {
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
                                      builder: (context) =>
                                           RateUsPage()));
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
                              height: MediaQuery.of(context).size.height * 0.07,
                              // width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: AppColors.kBtnColor, width: 1)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, top: 4, bottom: 4, right: 8),
                                child: ScrollingText(
                                  text: "Story of ${widget.data.storyTitle}",
                                  textStyle: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "BalooBhai",
                                      // letterSpacing: 0.5,
                                      color: AppColors.kBtnColor),
                                ),
                                // Text(
                                //   "Story of ${widget.data.storyTitle}",
                                //   // "Story of ${widget.data.title}",
                                //   overflow: TextOverflow.ellipsis,
                                //   textAlign: TextAlign.center,
                                //   style: const TextStyle(
                                //       fontSize: 25,
                                //       fontWeight: FontWeight.normal,
                                //       fontFamily: "BalooBhai",
                                //       // letterSpacing: 0.5,
                                //       color: AppColors.kBtnColor),
                                //     // GoogleFonts.meriendaOne().copyWith(
                                //     //     fontSize: 22,
                                //     //     fontWeight: FontWeight.bold,
                                //     //     letterSpacing: 0.5,
                                //     //     color: AppColors.kBtnColor
                                //     // )
                                // ),
                              ),
                            ),
                          ),
                          // SizedBox(
                          //     height: MediaQuery.of(context).size.height * 0.12,
                          //     child: Image.asset("assets/PNG/loin.png")),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
            // widget.data.images == null || widget.data.images!.isEmpty ? const SizedBox() :
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: CarouselSlider(
                options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    viewportFraction: 1,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    onPageChanged: (index, CarouselPageChangedReason) {
                      activeIndex = index;
                    }),
                items: imageSliders,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                child: Obx(
                  () => Stack(
                    children: [
                      // Text(widgetTxt.toString().replaceAll(",","").replaceAll('[', '').replaceAll('replaceAll]','')
                      //   ,
                      //   style: const TextStyle(color: Colors.grey, fontSize: 25,fontWeight: FontWeight.bold),),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Text(
                            listTxt
                                .toString()
                                .replaceAll(",", "")
                                .replaceAll('[', '')
                                .replaceAll(']', ''),
                            style: GoogleFonts.playfairDisplay().copyWith(
                              color: Colors.grey[800],
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              fontStyle: FontStyle.italic,
                              height: 1.8,
                            ),
                            // TextStyle(
                            //     color: Colors.grey[800],
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.bold,
                            //   fontFamily: GoogleFonts.tangerine().toString(),
                            // ),
                            textAlign: TextAlign.justify,
                            // textScaleFactor: 1.2,
                            softWrap: true,
                          ),
                        ),
                      )

                      ///
                      // CarouselSlider(
                      //   options: CarouselOptions(
                      //     height: MediaQuery.of(context).size.height,
                      //       // scrollPhysics: const BouncingScrollPhysics(),
                      //       viewportFraction: widget.data.story!.length.toDouble(),
                      //     // padEnds: false,
                      //     // pauseAutoPlayOnManualNavigate: false,
                      //       aspectRatio: 16/9,
                      //       // aspectRatio: widget.data.story!.length.toDouble(),
                      //       enlargeCenterPage: true,
                      //       scrollDirection: Axis.vertical,
                      //       autoPlay: true,
                      //       enableInfiniteScroll: false,
                      //       // onPageChanged: (index, CarouselPageChangedReason) {
                      //       //   activeIndex = index;
                      //       // }
                      //       ),
                      //   items: <Widget>[
                      //     Padding(
                      //       padding: const EdgeInsets.only(bottom: 16.0),
                      //       child: Text(
                      //         listTxt
                      //             .toString()
                      //             .replaceAll(",", "")
                      //             .replaceAll('[', '')
                      //             .replaceAll(']', ''),
                      //         style: const TextStyle(
                      //             color: AppColors.kBtnColor,
                      //             fontSize: 25,
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      ///
                      // FutureBuilder(
                      //   future: Future.value(listTxt.toString().replaceAll(","," ").replaceAll('[', '').replaceAll(']','')),
                      //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      //     return Text(snapshot.data.toString(),
                      //           style: const TextStyle(color: AppColors.kWhite, fontSize: 25,fontWeight: FontWeight.bold),);
                      //   },),
                      // StreamBuilder(
                      //   stream: Stream.value(listTxt.toString().replaceAll(","," ").replaceAll('[', '').replaceAll(']','')),
                      //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      //     return
                      //       Stack(
                      //       children: [
                      //         Text(listTxt.toString().replaceAll(","," ").replaceAll('[', '').replaceAll(']',''),
                      //           style: const TextStyle(color: AppColors.kWhite, fontSize: 25,fontWeight: FontWeight.bold),),
                      //         // Text(snapshot.data.toString(), style: TextStyle(color:AppColors.txtColor2, fontSize: 25,fontWeight: FontWeight.bold),),
                      //       ],
                      //     );
                      //   },),
                    ],
                  ),
                ),
              ),
            ),
             SizedBox(height: MediaQuery.of(context).size.height*0.08,)
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:



      Container(
        // color: Colors.red,
        decoration: BoxDecoration(
          color: AppColors.kBlack.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10)
        ),
        margin:const EdgeInsets.only(left: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed:

                controllerText.storyCategoryListModels.value.data!.indexWhere((element) => element.storyTitle == widget.data.storyTitle) == 0
                    ? null
                    : () {
                  int newIndex = controllerText.storyCategoryListModels.value.data!.indexWhere((element) => element.storyTitle == widget.data.storyTitle);

                  if (newIndex <
                      controllerText.storyCategoryListModels.value.data!.length) {
                    widget.data = controllerText.storyCategoryListModels.value.data![newIndex - 1];
                    MyRepo.currentStory = controllerText.storyCategoryListModels.value.data![newIndex - 1];
                    tts.stop();
                    listTxt.clear();
                    _ttsInit ();
                    setState(() {});
                  }
                }
                ,
                icon: const Icon(
                  Icons.skip_previous_rounded,
                  color: AppColors.kBtnColor,
                  size: 30,
                )),
            FloatingActionButton.small(
              backgroundColor: AppColors.kBtnColor,
              onPressed: () {
                setState(() {
                  print("=====before========  ${isPaused}");
                  isPaused = !isPaused;
                  print("======after=======  ${isPaused}");
                  isPaused == true ? tts.pause().then((value) =>  listTxt.removeLast()) : _ttsInit();
                });
              },
              child: isPaused ? const Icon(Icons.play_arrow) : const Icon(Icons.pause),
            ),
            IconButton(
                onPressed:

                (
                    controllerText.storyCategoryListModels.value.data!.lastIndexWhere((element) => element.storyTitle == widget.data.storyTitle) ==
                        controllerText.storyCategoryListModels.value.data!
                            .length)==true
                    ? null
                    : () {
                  print("=====++++++: ${controllerText.storyCategoryListModels.value.data!.lastIndexWhere((element) => element.storyTitle == widget.data.storyTitle) == controllerText.storyCategoryListModels.value.data!.length}");

                  int newIndex = controllerText.storyCategoryListModels.value.data!.indexWhere((element) => element.storyTitle == widget.data.storyTitle);

                  setState(() {
                    if (newIndex == controllerText.storyCategoryListModels.value.data!.length) {
                      widget.data = controllerText.storyCategoryListModels.value.data![newIndex];
                      MyRepo.currentStory = controllerText.storyCategoryListModels.value.data![newIndex];
                      print("========if ==  1 current Story :${MyRepo.currentStory.storyTitle}");

                      // ? tts.pause().then((value) =>  listTxt.removeLast()) : _ttsInit();
                      tts.stop();
                      listTxt.clear();
                      _ttsInit ();
                    }
                    else{
                      widget.data = controllerText.storyCategoryListModels.value.data![newIndex+1];
                      MyRepo.currentStory = controllerText.storyCategoryListModels.value.data![newIndex+1];
                      print("========if == current Story :${MyRepo.currentStory.storyTitle}");


                        tts.stop();
                        listTxt.clear();
                       _ttsInit ();



                      // isPlayNext=true;
                      // isPaused = true ;
                      // isPlayNext == true ?(){
                      //   listTxt.clear();
                      // isPaused=true;
                      // } : null;
                      // isPaused == true ?    _ttsInit() : null;

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

  _ttsInit () {
    tts = FlutterTts();
    tts.speak(widget.data.story.toString());
    // listTxt.value.clear();
    tts.setProgressHandler(
            (String text, int startOffset, int endOffset, String word) {
          print("================== word :$word");
          print("================== text :$text");
          // print("================== startOffset :$startOffset");
          // print("================== endOffset :$endOffset");
          listTxt.add(word);
          // widgetTxt.add(text);
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        });
    tts.setCompletionHandler(() {
      // Do something when speech is complete
      Get.to(()=>StoryFinish(data: widget.data,catName: widget.catName));
      // Get.to(() => SharePage(
      //   shareData: widget.data,
      //   catName: widget.catName,
      // ));
      print('Speech completed');
    });
  }

  _stop() {
    tts.stop();
  }
}
