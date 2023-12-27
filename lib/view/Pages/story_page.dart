import 'dart:convert';
import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import '../../main2.dart';
import '../../utils/MyRepo.dart';
import '../../view/Widgets/settingsDialog.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import '../../view/Pages/story_view_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/headers.dart';
import '../../controllers/chat_text_controller.dart';
import '../../model/storyCatListModel.dart';
import '../../utils/app_color.dart';
import '../Widgets/constWidgets.dart';

class StoryPage extends StatefulWidget {
  DataList? data;
  final String? catName;
  StoryPage({
    Key? key,
    required this.data,
    this.catName,
  }) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  // ChatImageController controllerImage= Get.put(ChatImageController());
  ChatTextController controllerText = Get.put(ChatTextController());
  late PackageInfo packageInfo;
  bool versionCheck1 = false;
  String version = '';
  var playStoreUrl = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> versionCheck() async {
    // for test
    // versionCheck1 = true;
    packageInfo = await PackageInfo.fromPlatform();
    var url;
    setState(() {
      // version = packageInfo.version; //+'\n'+Platform.operatingSystemVersion;
    });
    url = Uri.parse("http://story-telling.eduverse.uk/api/v1/version");

    final response = await http.get(url);
    var data = jsonDecode(response.body);
    print("====data: ${data}  ${packageInfo.version}=====");
    if (response.statusCode == 200) {
      versionCheck1 = true;
      if (Platform.isAndroid) {
        if (packageInfo.version != data['data']["staff_app_version"]) {
          if (data['data']["staff_android_status"] == 0) {
            setState(() {
              versionCheck1 = true;
              playStoreUrl = data['data']["staff_app_url"];
            });
          }
        }
      } else if (Platform.isIOS) {
        if (packageInfo.version != data['data']["staff_iphone_app_version"]) {
          if (data['data']["staff_ios_status"] == 0) {
            setState(() {
              versionCheck1 = true;
              playStoreUrl = data['data']["staff_iphone_app_url"].toString();
              // print("=====playStoreUrl: $playStoreUrl========");
            });
          }
          if (data['data']["staff_ios_status"] == 3) {
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    RxString abc = ''.obs;

    if (versionCheck1) {
      return Scaffold(
        body: Container(
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Update Available",
                        style: TextStyle(
                            color: AppColors.kPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            decoration: TextDecoration.underline),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: const Text(
                          "Please Update your app before using it",
                          style:
                              TextStyle(color: AppColors.kBlack, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                          onTap: () {
                            print("=====playStoreUrl:$playStoreUrl=====");
                            try {
                              launchUrl(Uri.parse(playStoreUrl)
                                  // playStoreUrl

                                  );
                            } on PlatformException {
                              launchUrl(Uri.parse(
                                  // "https://play.google.com/store/apps/details?id=com.americanlyceum.staff"
                                  playStoreUrl));
                            } finally {
                              launchUrl(Uri.parse(playStoreUrl
                                  // "https://play.google.com/store/apps/details?id=com.americanlyceum.staff"

                                  ));
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(2, 3),
                                    color: AppColors.kPrimary.withOpacity(0.2),
                                    blurRadius: 2.0,
                                    spreadRadius: 3.0)
                              ],
                              color: AppColors.kPrimary,
                              shape: BoxShape.rectangle,
                            ),
                            child: const Text(
                              "Update",
                              // ( Platform.isAndroid)? "Go to Play Store":"Go to App Store",
                              style: TextStyle(color: AppColors.kWhite),
                            ),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      // InkWell(
                      //   onTap: () async {
                      //
                      //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SplashScreen()), (Route<dynamic> route) => false);
                      //
                      //
                      //     //   login();
                      //   },
                      //   child: Container(
                      //       child: Text("Retry",style: TextStyle(color:AppColors.kPrimary ),)),
                      // ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "v $version",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.kBlack),
                  ),
                )
              ],
            )),
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.kScreenColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: storyByGptWidget(context),
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.kScreenColor,
          leading: IconButton(
            onPressed: () async {
              Navigator.pop(context);

              try {
                MyRepo.musicMuted.value == false ?
                await MyRepo.assetsAudioPlayer.open(
                    Playlist(audios: [
                      Audio.network(
                          "http://story-telling.eduverse.uk/public/s_1.mp3"),
                    ]),
                    loopMode: LoopMode.playlist) : await MyRepo.assetsAudioPlayer.stop();
              } catch (t) {
                //mp3 unreachable
              }
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.txtColor1,
            ),
          ),
          actions: [

            IconButton(
                onPressed: () {
                  showCustomSettingDialog(context);
                  // Get.to(const Settings());
                },
                icon: const Icon(
                  FontAwesomeIcons.gear,
                  color: AppColors.kPrimary,
                ))
          ],
        ),
        body: Obx(() => Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: Image.asset("assets/PNG/loin.png")),
                    ),
                    const Center(
                      child: Text(
                        "Listen Story",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "BalooBhai",
                            color: AppColors.txtColor1),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 250.0,
                        child: DefaultTextStyle(
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'Bobbers',
                              color: AppColors.kBtnColor),
                          child: Center(
                            child: AnimatedTextKit(
                              // totalRepeatCount: 3,
                              pause: const Duration(seconds: 2),
                              repeatForever: true,
                              animatedTexts: [
                                TyperAnimatedText(
                                    '${widget.data!.storyTitle}',
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "BalooBhai",
                                        color: AppColors.kBtnColor),
                                    textAlign: TextAlign.center),
                                // TyperAnimatedText('While your story of ${widget.data.title} is creating'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    // true
                    controllerText.state.value == ApiState.loading
                        ? Container(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/PNG/giphy2.gif",
                                  height: 125.0,
                                  width: 125.0,
                                ),

                                const SizedBox(
                                  height: 10,
                                ),

                                Center(
                                  child: SizedBox(
                                    width: 250.0,
                                    child: DefaultTextStyle(
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'Bobbers',
                                          color: AppColors.txtColor1),
                                      child: AnimatedTextKit(
                                        animatedTexts: [
                                          TyperAnimatedText(
                                              'Please wait ....'),
                                          TyperAnimatedText(
                                              'While your story of ${widget.data!.storyTitle} is creating'),
                                          // TyperAnimatedText('While your story of ${widget.data.title} is creating'),
                                        ],
                                        onTap: () {
                                          print("Tap Event");
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            child: controllerText.state.value ==
                                    ApiState.error
                                ? Container(
                                    child: Center(
                                        child: Text(
                                            controllerText.errorMsg.value)),
                                  )
                                : Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // Navigator.push(context, MaterialPageRoute(builder: (context) =>  StoryViewPage(storyType: widget.storyType,)));
                                        },
                                        child: Container(
                                          height: 220,
                                          // width: double.infinity,

                                          child: CachedNetworkImage(
                                            // imageUrl: kDemoImage,
                                            imageUrl:
                                            widget.data!.images!.isEmpty
                                              ? '' :
                                            widget.data!.images![0].imageUrl.toString(),
                                            fit: BoxFit.fill,
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
                                      ),
                                      const SizedBox(
                                        height: 35,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                              onPressed: controllerText.storyCategoryListModels.value.data!.indexWhere((element) => element.storyTitle == widget.data!.storyTitle) == 0
                                                  ? null
                                                  : () {
                                                      int newIndex = controllerText.storyCategoryListModels.value.data!.indexWhere((element) => element.storyTitle == widget.data!.storyTitle);

                                                      if (newIndex <
                                                          controllerText.storyCategoryListModels.value.data!.length) {
                                                        widget.data = controllerText.storyCategoryListModels.value.data![newIndex - 1];
                                                        MyRepo.currentStory = controllerText.storyCategoryListModels.value.data![newIndex - 1];
                                                        setState(() {});
                                                      }
                                                    },
                                              icon: const Icon(
                                                Icons.skip_previous_rounded,
                                                color: AppColors.kBtnColor,
                                                size: 30,
                                              )),
                                          GestureDetector(
                                            onTap: () async {
                                              print("=========widget.data.id = ${widget.data!.id}");
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          StoryViewPage(
                                                            data:
                                                            widget.data!,
                                                          )
                                                      // MyHomePage()
                                                  )
                                              );
                                              await MyRepo.assetsAudioPlayer.pause();
                                              Future.delayed(const Duration(microseconds: 500)).then((value) {
                                                getStory(widget.data!.id.toString());
                                              });
                                              countViewApi(widget.data!.id.toString());

                                            },
                                            child: const CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  AppColors.kBtnColor,
                                              child: Icon(
                                                CupertinoIcons
                                                    .play_arrow_solid,
                                                color: AppColors.txtColor1,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: (
                                                  controllerText.storyCategoryListModels.value.data!.lastIndexWhere((element) => element.storyTitle == widget.data!.storyTitle) ==
                                                      controllerText.storyCategoryListModels.value.data!
                                                          .length)==true
                                                  ? null
                                                  : () {
                                                print("=====++++++: ${controllerText.storyCategoryListModels.value.data!.lastIndexWhere((element) => element.storyTitle == widget.data!.storyTitle) == controllerText.storyCategoryListModels.value.data!.length}");

                                                int newIndex = controllerText.storyCategoryListModels.value.data!.indexWhere((element) => element.storyTitle == widget.data!.storyTitle);

                                                      setState(() {
                                                        if (newIndex == controllerText.storyCategoryListModels.value.data!.length) {
                                                          widget.data = controllerText.storyCategoryListModels.value.data![newIndex];
                                                          MyRepo.currentStory = controllerText.storyCategoryListModels.value.data![newIndex];
                                                        print("========if == current Story :${MyRepo.currentStory.storyTitle}");
                                                        }
                                                        else{
                                                          widget.data = controllerText.storyCategoryListModels.value.data![newIndex+1];
                                                          MyRepo.currentStory = controllerText.storyCategoryListModels.value.data![newIndex+1];
                                                          print("========if == current Story :${MyRepo.currentStory.storyTitle}");

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
                                    ],
                                  ),
                          ),
                  ],
                ),
              ),
            )),
      );
    }
  }

  countViewApi(var storyID) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('http://story-telling.eduverse.uk/api/v1/count-story-view'));
    request.fields.addAll({'story_id': storyID});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      // getStory(storyID);

    } else {
      print(response.reasonPhrase);
    }
  }
  getStory(var storyID) async {
    print("========= story id :$storyID");
    print("=========user id :${ GetStorage().read("userId").toString()}");
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://story-telling.eduverse.uk/api/v1/get-story'));
    request.fields.addAll({
      // 'story_id': '33',
      // 'user_id': '102'
      'story_id': '$storyID',
      'user_id': GetStorage().read("userId").toString()
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }
}
