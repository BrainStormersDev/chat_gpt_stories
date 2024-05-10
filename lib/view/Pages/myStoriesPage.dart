import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gpt_chat_stories/common/headers.dart';
import 'package:gpt_chat_stories/utils/my_indicator.dart';
import 'package:intl/intl.dart';
import '../../controllers/getStoriesController.dart';
import '../../controllers/story_watched_controller.dart';
import '../../utils/app_color.dart';
import '../../model/storyCatListModel.dart';
import '../../utils/MyRepo.dart';
import '../../view/Pages/story_category_page.dart';
import '../../model/StoryCategoryModels.dart';
import 'story_page.dart';
// class MyStories extends StatefulWidget {
//   const MyStories({super.key});
//
//   @override
//   State<MyStories> createState() => _MyStoriesState();
// }
//
// class _MyStoriesState extends State<MyStories> {
//   final TextEditingController _searachController = TextEditingController();
//
//   StoryWatchedController myStoriesController =
//   Get.put(StoryWatchedController());
//   RxString selectItems = "-1".obs;
//
//   String formatLargeValue(int value) {
//     final format = NumberFormat.compact();
//     return format.format(value);
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     myStoriesController.getMyStories();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//
//     Obx(()=>Scaffold(
//       body:
//
//       myStoriesController.state.value== ApiState.loading
//           ?
//       myIndicator():
//       myStoriesController.state.value== ApiState.error || myStoriesController.state.value== ApiState.notFound
//       ?
//       const Center(
//         child: Text("No Story Found", style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold,fontFamily: "BalooBhai",color: AppColors.kPrimary,),),
//       )
//           :
//
//       ListView.builder(
//           itemCount: myStoriesController
//               .myStoriesModel.value.data!.length,
//           itemBuilder: (context, index) {
//             return Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(),
//               child: Card(
//                 color: int.parse(selectItems.value.toString()) == index
//                     ? AppColors.kPrimary
//                     : null,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadiusDirectional.circular(20)),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     CachedNetworkImage(
//                       imageUrl:  myStoriesController
//                           .myStoriesModel.value.data![index].featuredImage.toString(),
//                       placeholder: (context, url) => Container(
//                         height: MediaQuery.of(context).size.height * 0.15,
//                         width: MediaQuery.of(context).size.height * 0.15,
//                         child: const CircularProgressIndicator(),
//                       ),
//                       errorWidget: (context, url, error) => Container(
//                         height: MediaQuery.of(context).size.height * 0.15,
//                         width: MediaQuery.of(context).size.height * 0.15,
//                         decoration:  BoxDecoration(
//                           image:
//                           DecorationImage(
//                               image: AssetImage(
//                                 "assets/PNG/img_4.png",
//                               ),
//                               fit: BoxFit.fill),
//
//                           borderRadius: BorderRadiusDirectional.only(
//                               topStart: Radius.circular(20),
//                               bottomStart: Radius.circular(20)),
//                           color: kBtnColor,
//                         ),
//                       ),
//                       imageBuilder: (context, imageProvider) => Container(
//                         height: MediaQuery.of(context).size.height * 0.15,
//                         width: MediaQuery.of(context).size.height * 0.15,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image: imageProvider, fit: BoxFit.fitWidth),
//                           borderRadius:
//                           const BorderRadiusDirectional.only(
//                               topStart: Radius.circular(20),
//                               bottomStart: Radius.circular(20)),
//                           color: kBtnColor,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.02,
//                     ),
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width / 2.1,
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                     myStoriesController
//                                         .myStoriesModel.value
//                                         .data![index].category!=null?
//                                     myStoriesController
//                                         .myStoriesModel.value
//                                         .data![index].category!.title
//                                         .toString()
//                                         :
//                                     "",
//                                     style: TextStyle(
//                                         fontSize: 13,
//                                         fontFamily: "BalooBhai",
//                                         color: int.parse(selectItems.value
//                                             .toString()) ==
//                                             index
//                                             ? AppColors.txtColor1
//                                             : Colors.grey)),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width / 2,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   myStoriesController
//                                       .myStoriesModel.value
//                                       .data![index]
//                                       .storyTitle
//                                       .toString(),
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: "DMSerifDisplayRegular",
//                                       color: int.parse(selectItems.value
//                                           .toString()) ==
//                                           index
//                                           ? AppColors.kWhite
//                                           : AppColors.txtColor1),
//                                 ),
//                               ),
//                               CircleAvatar(
//                                 radius: 20,
//                                 backgroundColor:
//                                 int.parse(selectItems.value.toString()) == index
//                                     ? AppColors.kWhite
//                                     : kBtnColor,
//                                 child: const Center(
//                                     child: Icon(
//                                       CupertinoIcons.play_arrow_solid,
//                                       color: AppColors.txtColor1,
//                                       size: 20,
//                                     )),
//                               ),
//
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width / 2.1,
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text("Rating  ",
//                                   style: TextStyle(
//                                       fontSize: 13,
//                                       fontFamily: "BalooBhai",
//                                       color: int.parse(selectItems.value
//                                           .toString()) ==
//                                           index
//                                           ? AppColors.txtColor1
//                                           : Colors.grey)),
//                               Expanded(
//                                 child: Text(
//                                     myStoriesController
//                                         .myStoriesModel.value
//                                         .data!
//                                     // .where((element) => element.storyTitle!.toString().toLowerCase().contains(_searachController.text.trim())).toList()
//                                     [index]
//                                         .averageRating ==
//                                         null
//                                         ? "0"
//                                         : myStoriesController
//                                         .myStoriesModel.value
//                                         .data!
//                                     // .where((element) => element.storyTitle!.toString().toLowerCase().contains(_searachController.text.trim())).toList()
//                                     [index]
//                                         .averageRating
//                                         .toString()
//                                         .split(".")
//                                         .first,
//                                     style: TextStyle(
//                                         fontSize: 13,
//                                         fontFamily: "BalooBhai",
//                                         color: int.parse(selectItems.value
//                                             .toString()) ==
//                                             index
//                                             ? AppColors.txtColor1
//                                             : Colors.grey)),
//                               ),
//                               Icon(Icons.visibility,
//                                   size: 15,
//                                   color: int.parse(selectItems.value.toString()) ==index
//                                       ? AppColors.txtColor1
//                                       : Colors.grey),
//                               Text(
//                                   " ${formatLargeValue(myStoriesController.myStoriesModel.value.data!
//                                   [index].viewCount!)}",
//                                   style: TextStyle(
//                                       fontSize: 13,
//                                       fontFamily: "BalooBhai",
//                                       color: int.parse(selectItems.value
//                                           .toString()) ==
//                                           index
//                                           ? AppColors.txtColor1
//                                           : Colors.grey)),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//     ));
//   }
//   Widget icon(index) {
//
//     MyStoriesData storyData = MyStoriesData(featuredImage: '');
//     storyData=myStoriesController
//         .myStoriesModel.value.data!
//         .where((element) => element
//         .storyTitle!
//         .toString()
//         .toLowerCase()
//         .contains(
//         _searachController
//             .text
//             .trim()))
//         .toList()[index];
//     return Container(
//       width: double.infinity,
//       decoration: const BoxDecoration(),
//       child: Card(
//         color: int.parse(selectItems.value.toString()) == index
//             ? AppColors.kPrimary
//             : null,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadiusDirectional.circular(20)),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CachedNetworkImage(
//               imageUrl: storyData.featuredImage.toString(),
//               placeholder: (context, url) => Container(
//                 height: MediaQuery.of(context).size.height * 0.15,
//                 width: MediaQuery.of(context).size.height * 0.15,
//                 child: const CircularProgressIndicator(),
//               ),
//               errorWidget: (context, url, error) => Container(
//                 height: MediaQuery.of(context).size.height * 0.15,
//                 width: MediaQuery.of(context).size.height * 0.15,
//                 decoration:  BoxDecoration(
//                   image:
//                   DecorationImage(
//                       image: AssetImage(
//                         "assets/PNG/img_4.png",
//                       ),
//                       fit: BoxFit.fill),
//
//                   borderRadius: BorderRadiusDirectional.only(
//                       topStart: Radius.circular(20),
//                       bottomStart: Radius.circular(20)),
//                   color: kBtnColor,
//                 ),
//               ),
//               imageBuilder: (context, imageProvider) => Container(
//                 height: MediaQuery.of(context).size.height * 0.15,
//                 width: MediaQuery.of(context).size.height * 0.15,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: imageProvider, fit: BoxFit.fitWidth),
//                   borderRadius:
//                   const BorderRadiusDirectional.only(
//                       topStart: Radius.circular(20),
//                       bottomStart: Radius.circular(20)),
//                   color: kBtnColor,
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.02,
//             ),
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 2.1,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                             myStoriesController
//                                 .myStoriesModel.value
//                                 .data![index].category!=null?
//                             myStoriesController
//                                 .myStoriesModel.value
//                                 .data![index].category!.title
//                                 .toString()
//                                 :
//                             "",
//                             style: TextStyle(
//                                 fontSize: 13,
//                                 fontFamily: "BalooBhai",
//                                 color: int.parse(selectItems.value
//                                     .toString()) ==
//                                     index
//                                     ? AppColors.txtColor1
//                                     : Colors.grey)),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 2,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           storyData
//                               .storyTitle
//                               .toString(),
//                           style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: "DMSerifDisplayRegular",
//                               color: int.parse(selectItems.value
//                                   .toString()) ==
//                                   index
//                                   ? AppColors.kWhite
//                                   : AppColors.txtColor1),
//                         ),
//                       ),
//                       CircleAvatar(
//                         radius: 20,
//                         backgroundColor:
//                         int.parse(selectItems.value.toString()) == index
//                             ? AppColors.kWhite
//                             : kBtnColor,
//                         child: const Center(
//                             child: Icon(
//                               CupertinoIcons.play_arrow_solid,
//                               color: AppColors.txtColor1,
//                               size: 20,
//                             )),
//                       ),
//
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 2.1,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Rating  ",
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontFamily: "BalooBhai",
//                               color: int.parse(selectItems.value
//                                   .toString()) ==
//                                   index
//                                   ? AppColors.txtColor1
//                                   : Colors.grey)),
//                       Expanded(
//                         child: Text(
//                             storyData
//                                 .averageRating ==
//                                 null
//                                 ? "0"
//                                 : storyData
//                                 .averageRating
//                                 .toString()
//                                 .split(".")
//                                 .first,
//                             style: TextStyle(
//                                 fontSize: 13,
//                                 fontFamily: "BalooBhai",
//                                 color: int.parse(selectItems.value
//                                     .toString()) ==
//                                     index
//                                     ? AppColors.txtColor1
//                                     : Colors.grey)),
//                       ),
//                       Icon(Icons.visibility,
//                           size: 15,
//                           color: int.parse(selectItems.value.toString()) ==index
//                               ? AppColors.txtColor1
//                               : Colors.grey),
//                       Text(
//                           " ${formatLargeValue(storyData.viewCount!)}",
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontFamily: "BalooBhai",
//                               color: int.parse(selectItems.value
//                                   .toString()) ==
//                                   index
//                                   ? AppColors.txtColor1
//                                   : Colors.grey)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }


class MyStoriesScreen extends StatefulWidget {
  final String catName;
  final StoryCatData? data;

  MyStoriesScreen({ this.catName="", this.data});

  @override
  State<MyStoriesScreen> createState() => _MyStoriesScreenState();
}

class _MyStoriesScreenState extends State<MyStoriesScreen> {
  RxString selectItems = "-1".obs;
  RxInt newVal = 0.obs;
  final TextEditingController _searchController = TextEditingController();
  StoriesController myStoriesController = Get.put(StoriesController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myStoriesController.getMyStories();
  }

  String formatLargeValue(int value) {
    final format = NumberFormat.compact();
    return format.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.close(2);
        Get.to(() => StoryCategoryPage());
        return false;
      },
      child: Scaffold(
        // backgroundColor: AppColors.kScreenColor,

        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFDDFE9),
                Color(0xFFB6E7F1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Obx(
                () => Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _searchController,
                    cursorColor: AppColors.kBtnColor,
                    onSubmitted: (value) {
                      _searchController.text = value;
                    },
                    onChanged: (value) {
                      myStoriesController.storyCategoryListModels.value.data!
                          .where((element) => element.storyTitle!
                          .toString()
                          .toLowerCase()
                          .contains(value))
                          .toList();
                      print(
                          "=======length :${myStoriesController.storyCategoryListModels.value.data!.where((element) => element.storyTitle!.toString().toLowerCase().contains(value)).toList().length}");
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: "Search Story...",
                      hintStyle: TextStyle(color: AppColors.kBtnColor),
                      suffixIcon: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.search,
                            color: AppColors.kBtnColor,
                            size: 40,
                          )),
                      enabledBorder:  OutlineInputBorder(
                        borderSide:
                        BorderSide(color: AppColors.kBtnColor, width: 2.0),
                      ),
                      focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.kBtnColor)),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(7.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myStoriesController.state.value == ApiState.loading
                      ? myIndicator()
                      : Expanded(
                    child: Container(
                      child: myStoriesController.state.value ==
                          ApiState.error
                          ? Center(
                          child: Text(
                            // GetStorage().read("bearerToken"),
                              myStoriesController.errorMsg.toString(),
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Bobbers',
                                color: AppColors.txtColor1
                            ),
                          ))
                          : SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                                children: List.generate(
                                    myStoriesController
                                        .storyCategoryListModels
                                        .value
                                        .data!
                                        .where((element) => element
                                        .storyTitle!
                                        .toString()
                                        .toLowerCase()
                                        .contains(_searchController
                                        .text
                                        .trim()))
                                        .toList()
                                        .length, (index) {
                                  return SizedBox(
                                    // height: 100,
                                      child: InkWell(
                                          onTap: () {
                                            selectItems.value = index.toString();
                                            MyRepo.currentStory.value =
                                            myStoriesController
                                                .storyCategoryListModels
                                                .value
                                                .data!
                                                .where((element) => element
                                                .storyTitle!
                                                .toString()
                                                .toLowerCase()
                                                .contains(
                                                _searchController
                                                    .text
                                                    .trim()))
                                                .toList()[index];
                                            nextPage(
                                                data: myStoriesController
                                                    .storyCategoryListModels
                                                    .value
                                                    .data!
                                                    .where((element) => element
                                                    .storyTitle!
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains(
                                                    _searchController
                                                        .text
                                                        .trim()))
                                                    .toList()[index], catName:
                                            myStoriesController
                                                .storyCategoryListModels
                                                .value
                                                .data!
                                                .where((element) => element
                                                .storyTitle!
                                                .toString()
                                                .toLowerCase()
                                                .contains(
                                                _searchController
                                                    .text
                                                    .trim()))
                                                .toList()[index].category!=null?
                                            myStoriesController
                                                .storyCategoryListModels
                                                .value
                                                .data!
                                                .where((element) => element
                                                .storyTitle!
                                                .toString()
                                                .toLowerCase()
                                                .contains(
                                                _searchController
                                                    .text
                                                    .trim()))
                                                .toList()[index].category!.title!
                                                :
                                                ""
                                            );
                                            // nextPage(
                                            //     data: storyCatListController
                                            //         .storyCategoryListModels
                                            //         .value
                                            //         .data![index]);
                                          },
                                          child: icon(index)));
                                  // return icon(data:storyCatController.storyCategoryModels.value.data![index],index: index);
                                }),

                            ),
                            SizedBox(height: 70,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget icon(index) {

    DataList storyData = DataList(featuredImage: '');
    storyData= myStoriesController
        .storyCategoryListModels
        .value
        .data!
        .where((element) => element
        .storyTitle!
        .toString()
        .toLowerCase()
        .contains(
        _searchController
            .text
            .trim()))
        .toList()[index];
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Card(
        color: int.parse(selectItems.value.toString()) == index
            ? AppColors.kBtnColor
            : null,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(20)),
        child: Container(

          decoration:
          int.parse(selectItems.value.toString()) == index
              ? BoxDecoration(
              color:
              AppColors.kBtnColor,
              borderRadius: BorderRadius.circular(20)
          )
              :
          BoxDecoration(
            borderRadius: BorderRadius.circular(20),

            gradient: LinearGradient(
              colors: [
                AppColors.kBackgroundTopColor,
                AppColors.kBackgroundBottomColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),


          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.height * 0.16,

                child: CachedNetworkImage(
                  imageUrl: storyData.featuredImage.toString(),
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                  const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/PNG/img_4.png",
                          ),
                          fit: BoxFit.fill),

                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(20),
                          bottomStart: Radius.circular(20)),
                      color: AppColors.kBtnColor,
                    ),
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                      borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(20),
                          bottomStart: Radius.circular(20)),
                      color: AppColors.kBtnColor,
                    ),
                  ),
                ),
              ),
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
                          child: Text(
                              widget.data == null ? '' : widget.data!.title!,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "BalooBhai",
                                  color:
                                  int.parse(selectItems.value.toString()) ==
                                      index
                                      ? AppColors.txtColor1
                                      : Colors.grey)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            storyData.storyTitle
                                .toString(),
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
                              storyData
                                  .averageRating
                                  .toString(),
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
                            storyData.viewCount !=
                                null
                                ? " ${formatLargeValue(storyData.viewCount!)}"
                                : "",
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
      ),
    );
  }

  nextPage({required DataList data,required String catName}) async {
    print("======Data==========${data.story}");


    Future.delayed(const Duration(milliseconds: 100), () {
      print("========== List =========");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StoryPage(
                data: data,
                catName: catName,
              )));
    });
  }
}
