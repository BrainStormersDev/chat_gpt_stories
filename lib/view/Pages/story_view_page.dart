import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_gpt_stories/utils/MyRepo.dart';
import 'package:chat_gpt_stories/view/Pages/rate_us_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
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
  const StoryViewPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
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
  // RxList<String> widgetTxt = <String>[].obs;
  List<String> widgetTxt = [];
  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.position.maxScrollExtent == _scrollController.offset
          ? _scrollController.jumpTo(_scrollController.position.minScrollExtent)
          : _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration:  const Duration(milliseconds: 1000), curve: Curves.easeInOut);
    });
    super.initState();
    tts = FlutterTts();
    tts.speak(widget.data.story.toString());
    tts.setProgressHandler(
        (String text, int startOffset, int endOffset, String word) {
      print("================== word :$word");
      print("================== text :$text");
      // print("================== startOffset :$startOffset");
      // print("================== endOffset :$endOffset");
      // nTxt.value = word;
      listTxt.add(word);
      widgetTxt.add(text);
    });
  }

  // @override
  // initState()  {
  //   // TODO: implement initState
  //   // print(controllerText.storyCategoryListModels.value.data!.first.story!+"=====Story========");
  //   String character = widget.data.story.toString();
  //   // String character = controllerText.storyCategoryListModels.value.data!.first.story!;
  //
  //   // _listen();
  //
  //   _speak(character);
  //
  //
  //
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     _scrollController.position.maxScrollExtent == _scrollController.offset
  //         ? _scrollController.jumpTo(_scrollController.position.minScrollExtent)
  //         : _scrollController.animateTo(
  //         _scrollController.position.maxScrollExtent,
  //         duration:  const Duration(milliseconds: 100000), curve: Curves.linear);
  //   });
  //
  //   super.initState();
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _stop();
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

    final List<Widget> imageSliders = imgList
        .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
                                          const RateUsPage()));
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
                                padding: const EdgeInsets.only(
                                    left: 8.0, top: 4, bottom: 4, right: 8),
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
            CarouselSlider(
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
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                child: ListView(
                  controller: _scrollController,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Stack(
                        children: [
                          // Text(widgetTxt.toString().replaceAll(",","").replaceAll('[', '').replaceAll('replaceAll]','')
                          //   ,
                          //   style: const TextStyle(color: Colors.grey, fontSize: 25,fontWeight: FontWeight.bold),),

                      Text(
                              listTxt
                              .toString()
                              .replaceAll(",", "")
                              .replaceAll('[', '')
                              .replaceAll(']', ''),
                          style: const TextStyle(
                              color: AppColors.kBtnColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
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

                    // Obx(()=>Stack(
                    //   //     mainAxisAlignment: MainAxisAlignment.start,
                    //   // crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       widget.data.story.toString(),
                    //       // controllerText.storyCategoryListModels.value.data!.first.story!,
                    //       style: const TextStyle(color: AppColors.kWhite, fontSize: 25,fontWeight: FontWeight.bold),
                    //       textAlign: TextAlign.start,
                    //     ),
                    //     StreamBuilder(
                    //       stream: _speak(widget.data.story.toString()).s,
                    //       // Stream.value(listTxt.value.toString().replaceAll(",","").replaceAll('[', '').replaceAll(']','')),
                    //       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    //         print("================ stream ${listTxt.length}");
                    //         return DefaultTextStyle(
                    //           style: const TextStyle(
                    //               fontSize: 20.0,
                    //               fontFamily: 'Bobbers',
                    //               color:  AppColors.kPrimary
                    //           ),
                    //           child:
                    //           // AnimatedTextKit(
                    //           //   animatedTexts: [
                    //           //     TyperAnimatedText(
                    //           //       snapshot.data.toString(),
                    //           //       // controllerText.storyCategoryListModels.value.data!.first.story!,
                    //           //       textStyle: TextStyle(color:AppColors.txtColor2, fontSize: 25,fontWeight: FontWeight.bold),
                    //           //       // speed: const Duration(milliseconds: 95),
                    //           //
                    //           //     ),
                    //           //
                    //           //   ],
                    //           //   onTap: () {
                    //           //     print("Tap Event");
                    //           //   },
                    //           //   stopPauseOnTap: true,
                    //           //   totalRepeatCount: 1,
                    //           //   // onFinished: (){
                    //           //   //   Navigator.push(context, MaterialPageRoute(builder: (context)=> const SharePage()));
                    //           //   // },
                    //           //
                    //           // ),
                    //         );
                    //         // Text(snapshot.data.toString());
                    //       },)
                    //
                    //
                    //
                    //     ///
                    //     // Card(
                    //     //   child: CachedNetworkImage(
                    //     //     imageUrl: controllerImage.images.isEmpty?"":controllerImage.images[3].url,
                    //     //     fit: BoxFit.cover,
                    //     //     progressIndicatorBuilder: (context, url, downloadProgress) =>
                    //     //         SizedBox(
                    //     //             height: 150,
                    //     //             width: 150,
                    //     //             child: Shimmer.fromColors(
                    //     //               baseColor: Colors.grey.withOpacity(.3),
                    //     //               highlightColor: Colors.grey,
                    //     //               child: Container(
                    //     //                 height: 220,
                    //     //                 width: 130,
                    //     //                 decoration: BoxDecoration(
                    //     //                     color: Colors.white,
                    //     //                     borderRadius: BorderRadius.circular(4)),
                    //     //               ),
                    //     //             )),
                    //     //     errorWidget: (context, url, error) => const Icon(Icons.error),
                    //     //   ),
                    //     // ),
                    //   ],
                    // )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _stop() {
    tts.stop();
  }
}
