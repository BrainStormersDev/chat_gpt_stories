import 'package:cached_network_image/cached_network_image.dart';
import '../../common/headers.dart';
import '../../controllers/chat_text_controller.dart';
import '../../model/storyCatListModel.dart';
import '../../utils/MyRepo.dart';
import '../../utils/app_color.dart';
import '../../utils/my_indicator.dart';
import '../../view/Pages/story_category_page.dart';
import '../../view/Widgets/constWidgets.dart';
import '../../view/Widgets/settingsDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/StoryCategoryModels.dart';
import 'story_page.dart';

class StoryCatList extends StatefulWidget {
  final String catName;
  final StoryCatData? data;
  StoryCatList({required this.catName, this.data});
  @override
  State<StoryCatList> createState() => _StoryCatListState();
}

class _StoryCatListState extends State<StoryCatList> {
  RxString selectItems = "-1".obs;
  RxInt newVal = 0.obs;
  final TextEditingController _searachController = TextEditingController();
  ChatTextController storyCatListController = Get.put(ChatTextController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     storyCatListController = Get.put(ChatTextController());
  }

  String formatLargeValue(int value) {
    final format = NumberFormat.compact();
    return format.format(value);
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
        Get.close(2);
        Get.to(()=>StoryCategoryPage());
        return false;
      },
      child: Scaffold(
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
          leading: IconButton(
            onPressed: () {

              Get.close(2);
              Get.to(()=>StoryCategoryPage());
              // Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.txtColor1,
            ),
          ),
        ),
        body: Obx(
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
                  controller: _searachController,
                  cursorColor: AppColors.kBtnColor,
                  onSubmitted: (value) {
                    _searachController.text=value;
                  },
                  onChanged: (value) {
                    storyCatListController
                        .storyCategoryListModels
                        .value
                        .data!.where((element) => element.storyTitle!.toString().toLowerCase().contains(value)).toList();
                        print("=======length :${ storyCatListController
                            .storyCategoryListModels
                            .value
                            .data!.where((element) => element.storyTitle!.toString().toLowerCase().contains(value)).toList().length}");
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: "Search Story...",
                    hintStyle:  TextStyle(color: AppColors.kPrimary),
                    suffixIcon: InkWell(
                        onTap: () {
                          // print("======searacb ${_searachController.text}=====");
                          // nextPage(data:Data(storyTitle: _searachController.text,images: []));
                        },
                        child:  Icon(
                          Icons.search,
                          color: AppColors.kPrimary,
                          size: 40,
                        )),
                    enabledBorder:const  OutlineInputBorder(
                      borderSide:
                      BorderSide(color: AppColors.kBtnColor, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.kBtnColor)),
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
                storyCatListController.state.value == ApiState.loading
                    ? myIndicator()
                    : Expanded(
                        child: Container(
                          child: storyCatListController.state.value ==
                                  ApiState.error
                              ? Center(
                                  child: Text(storyCatListController.errorMsg.value))
                              : SingleChildScrollView(
                                  child: Column(
                                      children: List.generate(
                                          storyCatListController
                                              .storyCategoryListModels
                                              .value
                                              .data!
                                              .where((element) => element.storyTitle!.toString().toLowerCase().contains(_searachController.text.trim())).toList()
                                              .length
                                          , (index) {
                                    return SizedBox(
                                        // height: 100,
                                        child:
                                            InkWell(
                                                onTap: () {
                                                  selectItems.value = index.toString();
                                                  MyRepo.currentStory=storyCatListController
                                                      .storyCategoryListModels
                                                      .value
                                                      .data!
                                                       .where((element) => element.storyTitle!.toString().toLowerCase().contains(_searachController.text.trim())).toList()
                                                  [index];
                                                  nextPage(
                                                      data: storyCatListController
                                                          .storyCategoryListModels
                                                          .value
                                                          .data![index]);

                                                },
                                                child: icon(index)));
                                    // return icon(data:storyCatController.storyCategoryModels.value.data![index],index: index);
                                  })),
                                ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget icon(index) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
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
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.height * 0.15,
              child: CachedNetworkImage(
                imageUrl: "",
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.height * 0.15,
                  decoration:  BoxDecoration(
                    image:
                    storyCatListController.storyCategoryListModels.value.data![index].images!.isEmpty

                        ?
                    DecorationImage(

                        image:
                        AssetImage("assets/PNG/img_4.png",),

                        fit: BoxFit.fill)

                        :
                      DecorationImage(

                      image:

                      NetworkImage(storyCatListController.storyCategoryListModels.value.data![index].images![0].imageUrl.toString()),

                  fit: BoxFit.fill),
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(20),
                        bottomStart: Radius.circular(20)),
                    color: AppColors.kBtnColor,
                  ),
                ),
                imageBuilder: (context, imageProvider) =>
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitWidth),
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
                        child: Text(widget.data==null? '':widget.data!.title,
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
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          storyCatListController
                              .storyCategoryListModels
                              .value
                              .data!
                               .where((element) => element.storyTitle!.toString().toLowerCase().contains(_searachController.text.trim())).toList()
                          [index].storyTitle.toString()
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
                      Text("Rating  ", style: TextStyle(
                          fontSize: 13,
                          fontFamily: "BalooBhai",
                          color:
                          int.parse(selectItems.value.toString()) ==
                              index
                              ? AppColors.txtColor1
                              : Colors.grey)),
                      Expanded(
                        child: Text(                          storyCatListController
                      .storyCategoryListModels
                          .value
                          .data!
                            // .where((element) => element.storyTitle!.toString().toLowerCase().contains(_searachController.text.trim())).toList()
                        [index].averageRating.toString(),
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
                          // " ${formatLargeValue(storyCatListController.storyCategoryListModels.value.data![index].viewCount!)}",
                          " ${formatLargeValue(storyCatListController
                              .storyCategoryListModels
                              .value
                              .data!
                              // .where((element) => element.storyTitle!.toString().toLowerCase().contains(_searachController.text.trim())).toList()
                          [index].viewCount!)}",
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
      print("========== List =========");
      // Get.put(ChatTextController()).getTextCompletion(query: searchText, catId: categId);
      // Get.put(ChatImageController()).getGenerateImages(searchText);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StoryPage(
                    data: data,
                    catName: widget.catName,
                  )));
    });
  }
}
