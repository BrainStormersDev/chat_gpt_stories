import 'package:cached_network_image/cached_network_image.dart';
import '../../view/Pages/create_new_story.dart';
import '../../controllers/story_watched_controller.dart';
import '../../model/StoryCategoryModels.dart';
import '../../utils/MyRepo.dart';
import '../../view/Pages/story_catList_page.dart';
import '../../view/Pages/story_page.dart';
import '../../view/Widgets/constWidgets.dart';
import '../../view/Widgets/customButton.dart';
import '../../view/Widgets/settingsDialog.dart';
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
    super.initState();
    changeSystemUIOverlayColor(AppColors.kScreenColor, AppColors.kWhite);
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
      ),
      body: WillPopScope(
          onWillPop: () async {
            changeSystemUIOverlayColor(
                AppColors.kSplashColor, AppColors.kWhite);
            Navigator.pop(context);
            return false;
          },
          // child: GetStorage().read("userName") == null
          child: GetStorage().read("userName").toString().isEmpty
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
                        Obx(()=>
                           Expanded(
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                // Content for Child 1
                                Obx(
                                  () {
                                    // storyWatchedController.getWatchedStory();
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
                         storyWatchedController.storyCategoryModels.value.data!.length==0?const Center(child: Text("No Watched Story Found"),):
                                    ListView.builder(itemCount: storyWatchedController.storyCategoryModels.value.data!.length, itemBuilder: (context,index){
                                  print("===== rating => ${storyWatchedController.storyCategoryModels.value.data!
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
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                   storyWatchedController.storyCategoryModels.value.data!
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
                        ),
                      ],
                    ),
                  ),
          ),
      floatingActionButton:
       Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // if(GetStorage().read("userName").toString().isEmpty)    Padding(
          if(GetStorage().read("userName").toString().isEmpty)    Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: FloatingActionButton(
              backgroundColor: AppColors.kBtnColor,
              onPressed: (){

                Get.to(()=>LogInPage());

              },child:const Icon(Icons.login,),),
          ),
          if(GetStorage().read("userName").toString().isNotEmpty )    Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: FloatingActionButton(
              backgroundColor: AppColors.kBtnColor,
              onPressed: (){
                setState((){
                  GetStorage().write("userName","");
                });
              },child:const Icon(Icons.logout_sharp,),),
          ),
          const  Spacer(),

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
        MyRepo.storyCat = data.title;
        nextPage(data: data);

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
    String catId = '${data.id}';
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.put(ChatTextController())
          .getTextCompletion(query: searchText, catId: catId);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StoryCatList(
                    catName: data.title,
                    data: data,
                  )));
    });
  }
  String formatLargeValue(int value) {
    final format = NumberFormat.compact();
    return format.format(value);
  }
}
