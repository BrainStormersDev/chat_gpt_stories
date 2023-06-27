import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_gpt_stories/controllers/create_new_story.dart';
import 'package:chat_gpt_stories/controllers/story_watched_controller.dart';
import 'package:chat_gpt_stories/model/StoryCategoryModels.dart';
import 'package:chat_gpt_stories/utils/MyRepo.dart';
import 'package:chat_gpt_stories/view/Pages/story_catList_page.dart';
import 'package:chat_gpt_stories/view/Pages/story_page.dart';
import 'package:chat_gpt_stories/view/Widgets/constWidgets.dart';
import 'package:chat_gpt_stories/view/Widgets/customButton.dart';
import 'package:chat_gpt_stories/view/Widgets/settingsDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../common/headers.dart';
import '../../controllers/chat_text_controller.dart';
import '../../controllers/story_cat_controller.dart';
import '../../utils/app_color.dart';
import '../../utils/my_indicator.dart';
import 'login_page.dart';

class StoryCategoryPage extends StatefulWidget {
  @override
  State<StoryCategoryPage> createState() => _StoryCategoryPageState();
}

class _StoryCategoryPageState extends State<StoryCategoryPage>
    with SingleTickerProviderStateMixin {
  // ChatImageController controller= Get.put(ChatImageController());

  RxString selectItems = "-1".obs;
  StoryCatController storyCatController = Get.put(StoryCatController());
  StoryWatchedController storyWatchedController =
      Get.put(StoryWatchedController());
  // List<IconOfStory> title=[IconOfStory(title: "Animals",url: "assets/PNG/storyLion.png",value: "Story of Animals for children"),IconOfStory(title: "Fairy",url: "assets/PNG/storyFairy.png",value: "Fairy Story for children"),IconOfStory(title: "Jeannie",url: "assets/PNG/storyJeannie.png",value: " Jeannie Story for children"),IconOfStory(title: "Hero",url: "assets/PNG/storyHero.png",value: "Story of hero for children"),IconOfStory(title: "Prince",url: "assets/PNG/storyprince.png",value: "Story of prince for children"),IconOfStory(title: "Toy Story",url: "assets/PNG/storyToy.png",value: "Toy Story for children"),IconOfStory(title: "Princes",url: "assets/PNG/storyPrinces.png",value: "Princes Story for children")];
  // List<IconOfStory> title=[IconOfStory(title: "Animals",url: "assets/PNG/storyLion.png",value: "Story of Animals for${GetStorage().read(kGender)} children"),IconOfStory(title: "Fairy",url: "assets/PNG/storyFairy.png",value: "Fairy Story for  ${GetStorage().read(kGender)} children"),IconOfStory(title: "Jeannie",url: "assets/PNG/storyJeannie.png",value: " Jeannie Story for  ${GetStorage().read(kGender)} children"),IconOfStory(title: "Hero",url: "assets/PNG/storyHero.png",value: "Story of hero for  ${GetStorage().read(kGender)} children"),IconOfStory(title: "Prince",url: "assets/PNG/storyprince.png",value: "Story of prince for  ${GetStorage().read(kGender)} children"),IconOfStory(title: "Toy Story",url: "assets/PNG/storyToy.png",value: "Toy Story for  ${GetStorage().read(kGender)} children"),IconOfStory(title: "Princes",url: "assets/PNG/storyPrinces.png",value: "Princes Story for  ${GetStorage().read(kGender)} children")];
  // List<IconOfStory> title=[IconOfStory(title: "Animals",url: "assets/PNG/storyLion.png",value: "Story of Animals for${GetStorage().read(kGender)} ${GetStorage().read(kAge)} years old"),IconOfStory(title: "Fairy",url: "assets/PNG/storyFairy.png",value: "Fairy Story for  ${GetStorage().read(kGender)} ${GetStorage().read(kAge)} years old"),IconOfStory(title: "Jeannie",url: "assets/PNG/storyJeannie.png",value: " Jeannie Story for  ${GetStorage().read(kGender)} ${GetStorage().read(kAge)} years old"),IconOfStory(title: "Hero",url: "assets/PNG/storyHero.png",value: "Story of hero for  ${GetStorage().read(kGender)} ${GetStorage().read(kAge)} years old"),IconOfStory(title: "Prince",url: "assets/PNG/storyprince.png",value: "Story of prince for  ${GetStorage().read(kGender)} ${GetStorage().read(kAge)} years old"),IconOfStory(title: "Toy Story",url: "assets/PNG/storyToy.png",value: "Toy Story for  ${GetStorage().read(kGender)} ${GetStorage().read(kAge)} years old"),IconOfStory(title: "Princes",url: "assets/PNG/storyPrinces.png",value: "Princes Story for  ${GetStorage().read(kGender)} ${GetStorage().read(kAge)} years old")];
  // const StoryCategoryPage({Key? key}) : super(key: key);
  // RxBool isMuted = false.obs;
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState

    tabController = TabController(length: 2, vsync: this);

    var mute = GetStorage().read(kMute);
    if (mute != null) {
      MyRepo.musicMuted.value = mute;
    }
    print("========repo muted value init  =${GetStorage().read(kMute)}");
    // MyRepo.musicMuted.value = GetStorage().read(kMute);
    super.initState();
    changeSystemUIOverlayColor(AppColors.kScreenColor, AppColors.kWhite);
    // storyWatchedController.getWatchedStory();
    print("========== init call =====");
    storyWatchedController.getWatchedStory();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print("========repo muted value  =${GetStorage().read(kMute)}");
    print("====userName  =${GetStorage().read("userName") }");
    print("========selectedGender  =${MyRepo.selectedGender.name}");

    return Scaffold(
      backgroundColor: AppColors.kScreenColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 40,
        elevation: 0,
        backgroundColor: AppColors.kScreenColor,
        title: storyByGptWidget(context),
        centerTitle: true,
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
        // leading: IconButton(
        //   onPressed: () async {
        //     MyRepo.assetsAudioPlayer.stop();
        //     changeSystemUIOverlayColor(AppColors.kSplashColor, AppColors.kWhite);
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     color: AppColors.txtColor1,
        //   ),
        // ),
      ),
      body: WillPopScope(
          onWillPop: () async {
            changeSystemUIOverlayColor(
                AppColors.kSplashColor, AppColors.kWhite);
            Navigator.pop(context);
            return false;
          },
          // child: GetStorage().read("userName") == null
          child: GetStorage().read("userName") == null
              ? Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              "I want to listen a story about",
                              style: TextStyle(
                                  color: AppColors.txtColor2, fontSize: 21),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          storyCatController.state.value == ApiState.loading
                              ? myIndicator()
                              : Container(
                                  // height: 400,
                                  child: storyCatController.state.value ==
                                          ApiState.error
                                      ? Center(
                                          child: Text(storyCatController
                                              .errorMsg.value))
                                      : GridView.count(
                                          childAspectRatio: 0.8,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 8.0,
                                          shrinkWrap: true,
                                          children: List.generate(
                                              storyCatController
                                                  .storyCategoryModels
                                                  .value
                                                  .data!
                                                  .length, (index) {
                                            return icon(
                                                data: storyCatController
                                                    .storyCategoryModels
                                                    .value
                                                    .data![index],
                                                index: index);
                                          }),
                                        ),
                                ),
                        ],
                      ),
                    ),
                  ),
                )
              : DefaultTabController(
                    length: 2, // Number of tabs
                    child: Column(
                      children: [
                        Container(
                          // height: 50,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: TabBar(
                            controller: tabController,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                              color: AppColors.kBtnColor,
                            ),
                            labelStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "BalooBhai",
                            ),
                            labelColor: AppColors.kBtnTxtColor,
                            unselectedLabelColor: AppColors.kGrey,
                            tabs: const [
                              Tab(
                                text: "All Stories",
                              ),
                              Tab(
                                text: 'My Stories',
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              // Content for Child 1
                              Obx(
                                () {
                                  storyWatchedController.getWatchedStory();
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Center(
                                            child: Text(
                                              "I want to listen a story about",
                                              style: TextStyle(
                                                  color: AppColors.txtColor2,
                                                  fontSize: 21),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          storyCatController.state.value ==
                                              ApiState.loading
                                              ? myIndicator()
                                              : Container(
                                            // height: 400,
                                            child: storyCatController
                                                .state.value ==
                                                ApiState.error
                                                ? Center(
                                                child: Text(
                                                    storyCatController
                                                        .errorMsg.value))
                                                : GridView.count(
                                              childAspectRatio: 0.8,
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 4.0,
                                              mainAxisSpacing: 8.0,
                                              shrinkWrap: true,
                                              children: List.generate(
                                                  storyCatController
                                                      .storyCategoryModels
                                                      .value
                                                      .data!
                                                      .length, (index) {
                                                return icon(
                                                    data: storyCatController
                                                        .storyCategoryModels
                                                        .value
                                                        .data![index],
                                                    index: index);
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                              ),
                              // Content for Child 2
                              ///tab two my stories
                              ///
                              // GetStorage().read("userName")==null

                              storyWatchedController.storyCategoryModels.value.status == false
                                  ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [const Text("Session Out, Please Login Your \nAccount To See Watched Story"),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                  CustomButton(
                                  text: "LogIn",
                                  height: MediaQuery.of(context).size.height * 0.08,
                                  width: MediaQuery.of(context).size.width * 0.3 ,
                                  textSize:18.0 ,
                                  color: AppColors.kBtnColor,
                                  onTap: (){
                                    MyRepo.islogInHomeScreen=true;
                                    Get.to(()=>LogInPage());

                                  },
                                ),]):
                                  storyWatchedController.storyCategoryModels.value.data==null?const Center(child: Text("No Watched Story Found"),):
                                  ListView.builder(itemCount: storyWatchedController.storyCategoryModels.value.data!.length, itemBuilder: (context,index){
                                print("===== rating => ${storyWatchedController.storyCategoryModels.value.data!
                                // .where((element) => element.storyTitle!.toString().toLowerCase().contains(_searachController.text.trim())).toList()
                                [index]
                                    .story!.averageRating
                                    .toString()}");
                                return  Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    // color: Colors.green,
                                    // color:int.parse(selectItems.value.toString())==index? AppColors.kPrimary:null,
                                    // border:int.parse(selectItems.value.toString())==index? Border.all(color: AppColors.kBtnColor):null,
                                  ),
                                  child: Card(
                                    color:
                                    int.parse(selectItems.value.toString()) ==
                                        index
                                        ? AppColors.kPrimary
                                        : null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadiusDirectional.circular(20)),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: "",
                                          placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                                height:
                                                MediaQuery.of(context).size.height *
                                                    0.15,
                                                width:
                                                MediaQuery.of(context).size.height *
                                                    0.15,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                        "assets/PNG/img_4.png",
                                                      ),
                                                      fit: BoxFit.fitWidth),
                                                  borderRadius:
                                                  BorderRadiusDirectional.only(
                                                      topStart: Radius.circular(20),
                                                      bottomStart:
                                                      Radius.circular(20)),
                                                  color: AppColors.kBtnColor,
                                                ),
                                              ),
                                          imageBuilder: (context, imageProvider) =>
                                              Container(
                                                height:
                                                MediaQuery.of(context).size.height *
                                                    0.15,
                                                width:
                                                MediaQuery.of(context).size.height *
                                                    0.15,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fitWidth),
                                                  borderRadius:
                                                  const BorderRadiusDirectional
                                                      .only(
                                                      topStart: Radius.circular(20),
                                                      bottomStart:
                                                      Radius.circular(20)),
                                                  color: AppColors.kBtnColor,
                                                ),
                                              ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width *
                                              0.02,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2.1,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(storyWatchedController.storyCategoryModels.value.data![index].story!.storyTitle.toString(),
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily: "BalooBhai",
                                                            color: int.parse(selectItems
                                                                .value
                                                                .toString()) ==
                                                                index
                                                                ? AppColors
                                                                .txtColor1
                                                                : Colors.grey)),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      // "Large Title here The Story",
                                                      // storyCatListController.storyCategoryListModels.value
                                                      //     .data![index].storyTitle
                                                      //     .toString()
                                                      storyWatchedController.storyCategoryModels.value.data!
                                                      // .where((element) => element.storyTitle!.toString().toLowerCase().contains(_searachController.text.trim())).toList()
                                                      [index]
                                                          .story!.storyTitle
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontFamily:
                                                          "DMSerifDisplayRegular",
                                                          color: int.parse(selectItems
                                                              .value
                                                              .toString()) ==
                                                              index
                                                              ? AppColors.kWhite
                                                              : AppColors
                                                              .txtColor1),
                                                    ),
                                                  ),
                                                  SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                                                  /// play button
                                                  // InkWell(
                                                  //   onTap:(){
                                                  //
                                                  //     Get.to(()=>StoryPage(data: null,catName: storyWatchedController.storyCategoryModels.value.data!
                                                  //     [index]
                                                  //         .story!.storyTitle,));
                                                  //
                                                  //
                                                  //
                                                  //   },
                                                  //   child: CircleAvatar(
                                                  //     radius: 20,
                                                  //
                                                  //     backgroundColor: int.parse(
                                                  //         selectItems.value
                                                  //             .toString()) ==
                                                  //         index
                                                  //         ? AppColors.kWhite
                                                  //         : AppColors.kBtnColor,
                                                  //     child: const Center(
                                                  //         child: Icon(
                                                  //           CupertinoIcons
                                                  //               .play_arrow_solid,
                                                  //           color: AppColors.txtColor1,
                                                  //           size: 20,
                                                  //         )),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2.1,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Rating  ",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: "BalooBhai",
                                                          color: int.parse(selectItems
                                                              .value
                                                              .toString()) ==
                                                              index
                                                              ? AppColors.txtColor1
                                                              : Colors.grey)),
                                                  Expanded(
                                                    child: Text(
                                                        storyWatchedController.storyCategoryModels.value.data!
                                                        // .where((element) => element.storyTitle!.toString().toLowerCase().contains(_searachController.text.trim())).toList()
                                                        [index]
                                                            .story!.averageRating==null?"0"
                                                            :storyWatchedController.storyCategoryModels.value.data!
                                                        // .where((element) => element.storyTitle!.toString().toLowerCase().contains(_searachController.text.trim())).toList()
                                                        [index]
                                                            .story!.averageRating.toString().split(".").first,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily: "BalooBhai",
                                                            color: int.parse(selectItems
                                                                .value
                                                                .toString()) ==
                                                                index
                                                                ? AppColors
                                                                .txtColor1
                                                                : Colors.grey)),
                                                  ),
                                                  // SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                                                  Icon(Icons.visibility,
                                                      size: 15,
                                                      color: int.parse(selectItems
                                                          .value
                                                          .toString()) ==
                                                          index
                                                          ? AppColors.txtColor1
                                                          : Colors.grey),
                                                  Text(
                                                    // " ${formatLargeValue(storyCatListController.storyCategoryListModels.value.data![index].viewCount!)}",
                                                      " ${formatLargeValue(   storyWatchedController.storyCategoryModels.value.data!
                                                      // .where((element) => element.storyTitle!.toString().toLowerCase().contains(_searachController.text.trim())).toList()
                                                      [index].story!.viewCount!)}",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: "BalooBhai",
                                                          color: int.parse(selectItems
                                                              .value
                                                              .toString()) ==
                                                              index
                                                              ? AppColors.txtColor1
                                                              : Colors.grey)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ///
          //  Column(children: [
          //
          //    Container(color: Colors.red,
          //    height: 50,
          //  child:  TabBar(
          //              controller:  tabController,
          //              indicator: BoxDecoration(
          //                borderRadius: BorderRadius.circular(
          //                  15.0,
          //                ),
          //                color: AppColors.kBtnColor,
          //              ),
          //              labelColor: AppColors.kBtnColor,
          //              unselectedLabelColor: AppColors.kGrey,
          //              tabs:  const [
          //                Tab(
          //                  text:"Add Request",
          //                ),
          //
          //                Tab(
          //                  text: 'Pending',
          //                ),Tab(
          //                  text: 'Pending',
          //                ),
          //
          //              ],
          //            ),
          //    ),
          //    SizedBox(
          //      height: 200,
          //      child: TabBarView(
          //          controller: tabController,
          //          children: [Text("data"),Text("2"),Text("2")]),
          //    )
          //
          //  ],)
          ///
          // Column(
          //   children: [
          //     Container(
          //       // height: 50,
          //       margin: const EdgeInsets.symmetric(
          //           horizontal: 10, vertical: 20),
          //       child: TabBar(
          //         controller:  tabController,
          //         indicator: BoxDecoration(
          //           borderRadius: BorderRadius.circular(
          //             15.0,
          //           ),
          //           color: AppColors.kBtnColor,
          //         ),
          //         labelColor: AppColors.kBtnColor,
          //         unselectedLabelColor: AppColors.kGrey,
          //         tabs:  [
          //           Tab(
          //             text:"Add Request",
          //           ),
          //
          //           Tab(
          //             text: 'Pending',
          //           ),
          //
          //         ],
          //       ),
          //     ),
          //     // Expanded(
          //     //   child: TabBarView(
          //     //       controller: tabController,
          //     //       children: [
          //     //     Text("data"),
          //     //   Text("data")]),
          //     // )
          //   ],
          // ),
          ),
      floatingActionButton:
       Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if(GetStorage().read("userName") == null)    Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: FloatingActionButton(
              backgroundColor: AppColors.kBtnColor,
              onPressed: (){
                Get.to(()=>LogInPage());
              },child:const Icon(Icons.login,),),
          ),
          if( MyRepo.islogIn )    Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: FloatingActionButton(
              backgroundColor: AppColors.kBtnColor,
              onPressed: (){
                GetStorage().write("userName","");
              },child:const Icon(Icons.login_outlined,),),
          ),

          Spacer(),
          FloatingActionButton(
            backgroundColor: AppColors.kBtnColor,
            onPressed: (){
              Get.to(()=>CreateNewStory());
            },child:const Icon(Icons.create,),),
        ],
      ),
    );
  }

  Widget icon({required StoryCatData data, required int index}) {
    return InkWell(
      onTap: () {
        selectItems.value = index.toString();
        print("========data:${selectItems.value}=======");
        // controller.getGenerateImages(data.story);
        MyRepo.storyCat = data.title;
        nextPage(data: data);
        // nextPage(title: title[int.parse(selectItems.value)].title);
      },
      child: Container(
        decoration: BoxDecoration(
            // color: Colors.red,
            color: int.parse(selectItems.value.toString()) == index
                ? AppColors.kPrimary
                : null,
            border: int.parse(selectItems.value.toString()) == index
                ? Border.all(color: AppColors.kBtnColor)
                : null),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              data.imageUrl,
              height: 80,
            ),
            Expanded(
              child: Text(
                data.title,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "BalooBhai",
                    color: int.parse(selectItems.value.toString()) == index
                        ? AppColors.kWhite
                        : AppColors.txtColor1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  nextPage({required StoryCatData data}) async {
    String searchText = '';
    // String catId = '${data.id}';
    String catId = '${data.id}';
    // String searchText ='Story of ${data.title} for children';

    // await MyRepo.assetsAudioPlayer.pause();

    Future.delayed(const Duration(milliseconds: 100), () {
      print("==========searchText:$searchText ,catId  $catId==========");
      Get.put(ChatTextController())
          .getTextCompletion(query: searchText, catId: catId);
      // Get.put(ChatImageController()).getGenerateImages(searchText);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StoryCatList(
                    catName: data.title,
                  )));
    });
  }
  String formatLargeValue(int value) {
    final format = NumberFormat.compact();
    return format.format(value);
  }
}
