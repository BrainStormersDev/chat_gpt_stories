import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:kids_stories/view/Pages/story_page.dart';
import '../../common/headers.dart';
import '../../controllers/CreateStoryController.dart';
import '../../controllers/my_created_story_controller.dart';
import '../../controllers/story_cat_controller.dart';
import '../../model/StoryCategoryModels.dart';
import '../../model/storyCatListModel.dart';
import '../../utils/MyRepo.dart';
import '../../utils/app_color.dart';
import '../../utils/mySnackBar.dart';
import '../../utils/my_indicator.dart';
import '../Widgets/constWidgets.dart';
import 'package:http/http.dart' as http;

import '../Widgets/dropdown.dart';
import '../Widgets/settingsDialog.dart';

FlutterTts tts = FlutterTts();
String nImg =
    "https://oaidalleapiprodscus.blob.core.windows.net/private/org-Tj2bgmByXCwmUTVaXbisDRtt/user-fnWIwmpjfSAZ7UgJ1aUvsDr8/img-AvWD1qVTHhblzFiUibU8xWuY.png?st=2023-07-19T06%3A51%3A19Z&se=2023-07-19T08%3A51%3A19Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-07-18T23%3A52%3A51Z&ske=2023-07-19T23%3A52%3A51Z&sks=b&skv=2021-08-06&sig=HRGLYC0%2BGO6i0SXQKmU%2BJatbSenHedyE52xmRo3aovw%3D";

class CreateNewStory extends StatefulWidget {
  CreateNewStory({Key? key}) : super(key: key);
  @override
  State<CreateNewStory> createState() => _CreateNewStoryState();
}

class _CreateNewStoryState extends State<CreateNewStory>
    with SingleTickerProviderStateMixin {
  CreateStoryController controller = Get.put(CreateStoryController());
  StoryCatController storyCatController = Get.put(StoryCatController());
  MyCreatedStoryController myCreatedStoryController = Get.put(MyCreatedStoryController());
  TabController? tabController;
  // List<XFile> images = [];
  RxString selectItems = "-1".obs;
  RxBool isCreating = true.obs;
  RxString title = "".obs;
  String? _selectedStatus ;
  StoryCatData? _selectedStoryCat ;
  List<StoryCatData>? selectedStoryList;
  List<String> statusList = [
    'Complete',
    'Incomplete',
  ];
  // Future<void> loadImages() async {
  //   // List<XFile> pickedImages = await ImagePicker().pickMultiImage();
  //
  //   if (images.isNotEmpty) {
  //     setState(() {
  //       images.addAll(pickedImages);
  //     });
  //   } else {
  //     setState(() {
  //       images = pickedImages;
  //     });
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);
    statusList.clear();
    selectedStoryList?.clear();
    _selectedStatus= storyCatController.storyCategoryModels.value.data!.first.title;
    _selectedStoryCat=storyCatController.storyCategoryModels.value.data?.first;
    for(int i=0;i<storyCatController.storyCategoryModels.value.data!.length;i++){
      statusList.add(storyCatController.storyCategoryModels.value.data![i].title);
      selectedStoryList?.add(storyCatController.storyCategoryModels.value.data![i]);
    }

    MyRepo.musicMuted.value == false? MyRepo.assetsAudioPlayer.play():null;
    super.initState();
  }

  Widget build(BuildContext context) {
    myCreatedStoryController.myCreatedStoryListFun();
    return WillPopScope(
      onWillPop: ()async{
        return isCreating.value;
      },
      child: Scaffold(
          backgroundColor: AppColors.kScreenColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: storyByGptWidget(context),
            centerTitle: true,
            backgroundColor: AppColors.kScreenColor,
            // leading: IconButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //     // Get.close(1);
            //     // Get.off(()=>StoryViewPage(data: MyRepo.currentStory));
            //   },
            //   icon: const Icon(
            //     Icons.arrow_back,
            //     color: AppColors.txtColor1,
            //   ),
            // ),
            actions: [
              IconButton(
                  onPressed: () async {
                    print("=====");
                    showCustomSettingDialog(context);
                  },
                  icon: const Icon(
                    FontAwesomeIcons.gear,
                    color: AppColors.kPrimary,
                  ))
            ],
          ),
          body:
          Obx(
            () {
              return SizedBox(
                child: controller.isLoading.isTrue
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: SizedBox(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Padding(
                                //   padding: const EdgeInsets.all(16.0),
                                //   child: myIndicator(),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset("assets/gif/writeStory.gif"),
                                ),
                                const Text("Creating....",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "BalooBhai",
                                    ))
                              ],
                            ),
                          ),
                        )))
                    : DefaultTabController(
                        length: 2,
                        child: Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, top: 20, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                controller.state.value == ApiState.loading
                                    ? const SizedBox()
                                    : TabBar(
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
                                          text: "Create Story",
                                        ),
                                        Tab(
                                          text: 'My Story',
                                        ),
                                      ],
                                    ),
                                Expanded(
                                  child: TabBarView(
                                      controller: tabController,
                                      children: [
                                        ///tab 1
                                        Column(
                                          children: [
                                            ///tab 1
                                            ///2323
                                            // const  Center(
                                            //   child:  Text(
                                            //     "Create Your Own Story",
                                            //     style: TextStyle(
                                            //         fontSize: 20,
                                            //         fontWeight: FontWeight.bold,
                                            //         fontFamily: "BalooBhai",
                                            //         color: AppColors.txtColor1),
                                            //   ),
                                            // ),

                                            // TextFormField(
                                            //   controller:TextEditingController(),
                                            //   cursorColor: AppColors.kBtnColor,
                                            //   style:const TextStyle(fontSize: 32),
                                            //   decoration:  InputDecoration(
                                            //     hintText:"Story Title",
                                            //     hintStyle:  const TextStyle(color: AppColors.kGrey,fontSize: 32),
                                            //     enabledBorder: const OutlineInputBorder(
                                            //       borderSide:
                                            //       BorderSide(color: Colors.transparent, width: 2.0),
                                            //     ),
                                            //     filled: false,
                                            //     fillColor: AppColors.textFieldColor,
                                            //     focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.kBtnColor)),
                                            //     border: const OutlineInputBorder(
                                            //       borderRadius: BorderRadius.all(
                                            //         Radius.circular(7.0),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                            // Text("your story here"),
                                            ///123
                                            Expanded(
                                                child: controller.state.value ==
                                                        ApiState.notFound
                                                    ?  Center(
                                                        child: SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisAlignment:MainAxisAlignment.center,
                                                            children: [
                                                           Image.asset(MyRepo.dashboardIcon[storyCatController.storyCategoryModels.value.data?.where((element) => element.title==_selectedStatus).first.id-1].toString(),height: 250,),
                                                              const Text(
                                                                "You Can Create Your Own Story",
                                                                style: TextStyle(
                                                                    fontSize: 20,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        "BalooBhai",
                                                                    color: AppColors.kGrey),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    :
                                                    // const  SizedBox()
                                                    SizedBox(
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                "assets/gif/kid.gif",
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.4,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        12.0),
                                                                child: Text(
                                                                  "Story $title Successfully Created.You Can Create Another Story",
                                                                  style: const TextStyle(
                                                                      fontSize: 20,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: "BalooBhai",
                                                                      color: AppColors.kGrey),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                // ListView.builder(
                                                //         reverse: true,
                                                //         itemCount: controller.messages.length,
                                                //         itemBuilder:
                                                //             (BuildContext context, int index) {
                                                //           final textData =
                                                //               controller.messages[index];
                                                //           print("==== ${textData.index}");
                                                //           return textData.index == -999999
                                                //               ? MyTextCard(textData: textData)
                                                //               : TextCard(textData: textData);
                                                //         },
                                                //       ),
                                                ),

                                            ///images
                                            // images.isNotEmpty?const SizedBox():
                                            // const Icon(
                                            //   Icons.add_photo_alternate_outlined,
                                            //   size: 140,
                                            //   color: AppColors.kBtnColor,
                                            // ),

                                            // SingleChildScrollView(
                                            //   scrollDirection: Axis.horizontal,
                                            //   child: Row(
                                            //     mainAxisAlignment: MainAxisAlignment.start,
                                            //     crossAxisAlignment: CrossAxisAlignment.start,
                                            //     children: List.generate(images.length, (index) {
                                            //       XFile image = images[index];
                                            //       return Padding(
                                            //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            //         child: SizedBox(
                                            //             // height: 200,
                                            //             width: 100,
                                            //             child: Stack(
                                            //               // alignment: Alignment.centerRight,
                                            //               children: [
                                            //                 Image.file(File(image.path),fit: BoxFit.fill,),
                                            //                 InkWell(
                                            //                   onTap: () {
                                            //                     setState(() {
                                            //                       images.removeWhere((element) =>
                                            //                           element.path == image.path);
                                            //                     });
                                            //                   },
                                            //                   child: const Positioned(
                                            //                       right: 0,
                                            //                       top: 10,
                                            //                       child: CircleAvatar(
                                            //                           radius: 16,
                                            //                           backgroundColor: Colors.red,
                                            //                           child: Icon(
                                            //                             Icons.close,
                                            //                             color: Colors.white,
                                            //                           ))),
                                            //                 )
                                            //               ],
                                            //             )),
                                            //       );
                                            //     }),
                                            //   ),
                                            // ),
                                            // controller.state.value == ApiState.loading
                                            //     ? Container(
                                            //     height: MediaQuery.of(context).size.height,
                                            //     width: MediaQuery.of(context).size.width,
                                            //     color: Colors.black.withOpacity(0.3),
                                            //     child: Center(child: myIndicator()))
                                            //     : const SizedBox(),
                                            controller.state.value ==
                                                    ApiState.loading
                                                ? const SizedBox()
                                                : Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                      width: 110,
                                                      child: DropDownWidget(
                                                        value: _selectedStatus,
                                                        items: statusList.map<
                                                            DropdownMenuItem<String>>(
                                                                (String value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: Text(value),
                                                              );
                                                            }).toList(),
                                                        hint: 'Select Status',
                                                        onChangedVal: (String? value) {
                                                          setState(() {
                                                            FocusScope.of(context)
                                                                .requestFocus(
                                                                FocusNode());
                                                            _selectedStatus = value!;
                                                          });
                                                          print(_selectedStatus?.toLowerCase());
                                                        },
                                                      ),
                                                    ),
                                                     SizedBox(width: MediaQuery.of(context).size.width*0.02),
                                                    Expanded(
                                                      child: SearchTextFieldWidget(
                                                          color: AppColors.kBtnColor
                                                              .withOpacity(0.8),
                                                          textEditingController:
                                                              controller.searchTextController,
                                                          onTap: () {


                                                            // print("====== build call ${storyCatController.storyCategoryModels.value.data?.where((element) => element.title==_selectedStatus).first.id}");

                                                            print("============== ${_selectedStatus}");
                                                            if (controller.searchTextController.text.trim().isEmpty) {
                                                              MySnackBar.snackBarRed(
                                                                  title: "Alert", message: "Story title required ( * )");
                                                            } else {
                                                              title.value = controller.searchTextController.text.trim();
                                                              controller.storyCreateCall(controller.searchTextController.text.trim().toString(),storyCatController.storyCategoryModels.value.data?.where((element) => element.title==_selectedStatus).first.id);
                                                              myCreatedStoryController.myCreatedStoryListFun();
                                                              isCreating.value=false;
                                                            }
                                                          }),
                                                    ),
                                                  ],
                                                ),

                                          ],
                                        ),
                                        ///tab 2
                                        myCreatedStoryController.myCreatedStoryList.value.data!.isEmpty
                                            ? const Center(
                                                child: Text(
                                                  "You Haven't Created Any Story",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: "BalooBhai",
                                                      color: AppColors.txtColor1),
                                                ),
                                              )
                                            : Column(
                                                children: [
                                                  Expanded(
                                                      child:
                                                          SingleChildScrollView(
                                                              child: Column(
                                                    children: List.generate(
                                                        myCreatedStoryController
                                                            .myCreatedStoryList
                                                            .value
                                                            .data!
                                                            .length,
                                                        (index) => InkWell(
                                                            onTap: () {
                                                              nextPage(
                                                                  data: myCreatedStoryController
                                                                      .myCreatedStoryList
                                                                      .value
                                                                      .data![index]);
                                                            },
                                                            child: icon(index))),
                                                  ))),
                                                  // TextButton(onPressed: (){
                                                  //   print("============ <send>=========");
                                                  //   // createNewUserStory();
                                                  //
                                                  //
                                                  //
                                                  //   }, child: const Text("send"))
                                                ],
                                              )
                                      ]),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
              );
            },
          )),
    );
  }

  Widget icon(index) {
    // print(widget.catName);
    // print("====< object > === ${myCreatedStoryController.myCreatedStoryList.value.data![index].images!.first.imageUrl.toString()}");
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          // color: Colors.green,
          // color:int.parse(selectItems.value.toString())==index? AppColors.kPrimary:null,
          // border:int.parse(selectItems.value.toString())==index? Border.all(color: AppColors.kBtnColor):null,
          ),
      child: Card(
        color: int.parse(selectItems.value.toString()) == index
            ? AppColors.kPrimary
            : null,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.height * 0.15,
              child:
              CachedNetworkImage(
                imageUrl: myCreatedStoryController.myCreatedStoryList.value
                    .data![index].images!.first.imageUrl
                    .toString(),
                // imageUrl: nImg,
                placeholder: (context, url) => myIndicator(),
                errorWidget: (context, url, error) => Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.height * 0.15,
                  padding:const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/PNG/loin.png",
                        ),
                        fit: BoxFit.fitWidth),
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(20),
                        bottomStart: Radius.circular(20)),
                    // color: AppColors.kBtnColor,
                  ),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.fitWidth),
                    borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(20),
                        bottomStart: Radius.circular(20)),
                    color: AppColors.kBtnColor,
                  ),
                ),
              ),
            ),
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.15,
            //   width: MediaQuery.of(context).size.height * 0.15,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image:
            //         storyCatListController.storyCategoryListModels.value.data![index].images!.isEmpty ?
            //         const NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png?20200912122019") :
            //         NetworkImage(storyCatListController.storyCategoryListModels.value.data![index].images!.first.imageUrl.toString()),
            //         // AssetImage("assets/PNG/img_4.png"),
            //         fit: BoxFit.fitWidth),
            //     borderRadius: BorderRadiusDirectional.only(
            //         topStart: Radius.circular(20),
            //         bottomStart: Radius.circular(20)),
            //     color: AppColors.kBtnColor,
            //   ),
            //
            //
            //   // child: storyCatListController.storyCategoryListModels.value.data![index].images![index].imageUrl == "" ? const SizedBox() :
            //   // Image.network(storyCatListController.storyCategoryListModels.value.data![index].images!.first.imageUrl.toString())
            //   // child: Image.asset("assets/PNG/img_4.png", fit: BoxFit.fitWidth,),
            // ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text( myCreatedStoryController.myCreatedStoryList.value.data![index].storyTitle.toString(),
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: "BalooBhai",
                                color:
                                    int.parse(selectItems.value.toString()) ==
                                            index
                                        ? AppColors.txtColor1
                                        : Colors.grey)),
                      ),
                      // SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          myCreatedStoryController
                              .myCreatedStoryList.value.data![index].storyTitle
                              .toString()
                          // "Large Title here The Story",
                          // storyCatListController.storyCategoryListModels.value
                          //     .data![index].storyTitle
                          //     .toString()
                          // storyCatListController
                          //     .storyCategoryListModels
                          //     .value
                          //     .data!
                          //     .where((element) => element.storyTitle!.toString().toLowerCase().contains(_searachController.text.trim())).toList()
                          // [index].storyTitle.toString()
                          ,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "DMSerifDisplayRegular",
                              color: int.parse(selectItems.value.toString()) ==
                                      index
                                  ? AppColors.kWhite
                                  : AppColors.txtColor1),
                        ),
                      ),
                      // SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            int.parse(selectItems.value.toString()) == index
                                ? AppColors.kWhite
                                : AppColors.kBtnColor,
                        child: const Center(
                            child: Icon(
                          CupertinoIcons.play_arrow_solid,
                          color: AppColors.txtColor1,
                          size: 20,
                        )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rating  ",
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: "BalooBhai",
                              color: int.parse(selectItems.value.toString()) ==
                                      index
                                  ? AppColors.txtColor1
                                  : Colors.grey)),
                      Expanded(
                        child: Text(
                            myCreatedStoryController.myCreatedStoryList.value
                                .data![index].averageRating
                                .toString(),
                            //
                            //     storyCatListController
                            //     .storyCategoryListModels.value.data!
                            // // .where((element) => element.storyTitle!.toString().toLowerCase().contains(_searachController.text.trim())).toList()
                            // [index].averageRating.toString(),
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: "BalooBhai",
                                color:
                                    int.parse(selectItems.value.toString()) ==
                                            index
                                        ? AppColors.txtColor1
                                        : Colors.grey)),
                      ),
                      // SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                      Icon(Icons.visibility,
                          size: 15,
                          color:
                              int.parse(selectItems.value.toString()) == index
                                  ? AppColors.txtColor1
                                  : Colors.grey),
                      Text(
                          myCreatedStoryController
                              .myCreatedStoryList.value.data![index].viewCount
                              .toString(),
                          // " ${formatLargeValue(storyCatListController.storyCategoryListModels.value.data![index].viewCount!)}",
                          //   " ${formatLargeValue(storyCatListController
                          //       .storyCategoryListModels
                          //       .value
                          //       .data!
                          //   // .where((element) => element.storyTitle!.toString().toLowerCase().contains(_searachController.text.trim())).toList()
                          //   [index].viewCount!)}",
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: "BalooBhai",
                              color: int.parse(selectItems.value.toString()) ==
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
  }

  nextPage({required DataList data}) async {
    print("======Data==========${data.story}");
    String searchText = '';
    String categId = data.id.toString();
    // String searchText ='${data.storyTitle}';
    // String searchText ='${data.title}';
    // String searchText ='Story of ${data.title} for children';

    Future.delayed(const Duration(milliseconds: 100), () {
      MyRepo.isSelectedMyStory.value = true;
      print("========== List =========");
      // Get.put(ChatTextController()).getTextCompletion(query: searchText, catId: categId);
      // Get.put(ChatImageController()).getGenerateImages(searchText);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StoryPage(
                    data: data,
                    catName: "",
                  )));
    });
  }
}

// class TextCard extends StatelessWidget {
//   TextCard({Key? key, this.textData, this.index}) : super(key: key);
//
//   var textData;
//   var index;
//
//   RxList<RxBool> list = <RxBool>[].obs;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         tts.speak(textData.text);
//       },
//       onDoubleTap: () {
//         tts.stop();
//       },
//       child: Container(
//         color: AppColors.kBtnColor.withOpacity(0.1),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Container(
//                   //   height: 40,
//                   //   width: 40,
//                   //   decoration: BoxDecoration(
//                   //       color: Colors.green.withOpacity(0.9),
//                   //       borderRadius: BorderRadius.circular(100)),
//                   //   child: const Icon(
//                   //     Icons.ac_unit,
//                   //     color: Colors.white,
//                   //   ),
//                   // ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Text(
//                       textData.text.toString(),
//                       style: const TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 6),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   // InkWell(
//                   //     onTap: () {
//                   //       Share.share(textData.text);
//                   //     },
//                   //     child: const Icon(Icons.share, size: 28)),
//                   const SizedBox(width: 20),
//                   InkWell(
//                       onTap: () {
//                         Clipboard.setData(ClipboardData(text: textData.text));
//                       },
//                       child: const Icon(Icons.copy, size: 28)),
//                   const SizedBox(width: 20),
//                   //
//                   // InkWell(
//                   //     onTap: () {
//                   //       tts.speak(textData.text);
//                   //       tts.setCompletionHandler(() {
//                   //         list[index].value=false;
//                   //       });
//                   //     },
//                   //     child:list[index].value==false? const Icon(Icons.pause, size: 28): const Icon(Icons.play_arrow, size: 28)),
//                 ],
//               ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class MyTextCard extends StatelessWidget {
//   MyTextCard({Key? key, this.textData}) : super(key: key);
//
//   var textData;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             height: 40,
//             width: 40,
//             decoration: BoxDecoration(
//                 color: Colors.green.withOpacity(0.9),
//                 borderRadius: BorderRadius.circular(100)),
//             child: const Icon(
//               Icons.person,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               textData.text.toString(),
//               style: const TextStyle(fontSize: 18),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//
//
//
//
// }

class SearchTextFieldWidget extends StatelessWidget {
  final TextEditingController? textEditingController;
  final VoidCallback? onTap;
  var color;

  SearchTextFieldWidget({
    Key? key,
    this.color,
    this.textEditingController,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _searchTextField(context);
  }

  Widget _searchTextField(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            // margin: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kBtnColor.withOpacity(.2),
                    offset: const Offset(0.0, 0.50),
                    spreadRadius: 1,
                    blurRadius: 1,
                  )
                ]),
            child: Column(
              children: [
                Row(
                  children: [
                     SizedBox(width: MediaQuery.of(context).size.width*0.02),
                    Expanded(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 60),
                        child: Scrollbar(
                          child: TextField(
                            style: const TextStyle(fontSize: 14),
                            controller: textEditingController,
                            maxLines: null,
                            decoration:  const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type Story Title Here...",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.02),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(40)),
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ),
        // const SizedBox(width: 6)
      ],
    );
  }
}
