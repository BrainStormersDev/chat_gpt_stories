import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gpt_chat_stories/utils/mySnackBar.dart';
import '../../controllers/story_watched_controller.dart';
import '../../model/StoryCategoryModels.dart';
import '../../utils/MyRepo.dart';
import '../../utils/app_size.dart';
import '../../view/Pages/story_catList_page.dart';
import '../../view/Widgets/constWidgets.dart';
import '../../view/Widgets/settingsDialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../common/headers.dart';
import '../../controllers/getStoriesController.dart';
import '../../controllers/story_cat_controller.dart';
import '../../utils/app_color.dart';
import '../../utils/my_indicator.dart';
import 'login_page.dart';
import 'myStoriesPage.dart';
import 'new_story.dart';

class StoryCategoryPage extends StatefulWidget {
  @override
  State<StoryCategoryPage> createState() => _StoryCategoryPageState();
}

class _StoryCategoryPageState extends State<StoryCategoryPage>
    with SingleTickerProviderStateMixin {
  RxString selectItems = "-1".obs;
  bool _isNetworkConnected = true;

  StoryCatController storyCatController = Get.put(StoryCatController());
  // StoryWatchedController storyWatchedController =
  //     Get.put(StoryWatchedController());
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);
    var mute = GetStorage().read(kMute);
    if (mute != null) {
      MyRepo.musicMuted.value = mute;
    }
    super.initState();
    changeSystemUIOverlayColor(AppColors.kScreenColor, AppColors.kWhite);
    // if(GetStorage().read("userName").toString().isNotEmpty)
    //   {storyWatchedController.getWatchedStory();}

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
          changeSystemUIOverlayColor(AppColors.kSplashColor, AppColors.kWhite);
          Navigator.pop(context);
          return false;
        },
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
                        // if (_isNetworkConnected)
                        //   Container(
                        //       margin:
                        //       EdgeInsets.only(bottom: AppSizes.appVerticalMd * 0.2),
                        //       child: Column(
                        //         children: [
                        //           const Text(
                        //             "No Internet Connection",
                        //             style: TextStyle(
                        //                 color: AppColors.kRed, fontWeight: FontWeight.w700),
                        //           ),
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: const [
                        //               SpinKitWave(
                        //                 color:AppColors.kPrimary,
                        //                 size: 20.0,
                        //               ),
                        //               SizedBox(width: 10,),
                        //               Text("Connecting to internet...",style: TextStyle(
                        //                   color: AppColors.kPrimary, fontWeight: FontWeight.w700),)
                        //             ],
                        //           )
                        //         ],
                        //       )),
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
                                        child: Text("Something went wrong please try again"))
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
                length: 2,
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
                            text: "Our Stories",
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
                          Obx(() {
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          }),
                          // MyStories(),
                          MyStoriesScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (GetStorage().read("userName").toString().isEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: FloatingActionButton(
                heroTag: 'login',
                backgroundColor: AppColors.kBtnColor,
                onPressed: () {
                  Get.to(() => LogInPage());
                },
                child: const Icon(
                  Icons.login,
                ),
              ),
            ),
          if (GetStorage().read("userName").toString().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: FloatingActionButton(
                heroTag: 'logout',

                backgroundColor: AppColors.kBtnColor,
                onPressed: () {
                  setState(() {
                    GetStorage().write("userName", '');
                    MySnackBar.snackBarPrimary(
                        title: 'Logout', message: 'Logout SuccessFully');
                  });
                },
                child: const Icon(
                  Icons.logout_sharp,
                ),
              ),
            ),
          Spacer(),
          SizedBox(
            width: Get.width / 1.3,
            child: FloatingActionButton(
              heroTag: 'createStory',

              backgroundColor: AppColors.kBtnColor,
              onPressed: () async {
                if (GetStorage().read("userName").toString().isEmpty) {
                  Get.to(() => LogInPage());
                } else {
                  // await storyCatController.getCat();
                  if (storyCatController.state.value == ApiState.success) {
                    logger.i(storyCatController.state.value);
                    Get.to(() => NewStoryCreate(
                        catData: storyCatController
                            .storyCategoryModels.value.data!));
                  } else {
                    MySnackBar.snackBarRed(
                        title: 'Error', message: 'Something Went Wrong!');
                  }
                }
              },
              child: const Text(
                'Create Story',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget icon({required StoryCatData data, required int index}) {
    return InkWell(
      onTap: () {
        selectItems.value = index.toString();
        print("========data:${selectItems.value}=======");
        MyRepo.storyCat = data.title!;
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
              data.imageUrl!,
              height: 80,
            ),
            Expanded(
              child: Text(
                data.title!,
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
      Get.put(StoriesController()).getTextCompletion(query: searchText, catId: catId);


      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StoryCatList(
                    catName: data.title!,
                    data: data,
                  )));
    });
  }

  String formatLargeValue(int value) {
    final format = NumberFormat.compact();
    return format.format(value);
  }
}

