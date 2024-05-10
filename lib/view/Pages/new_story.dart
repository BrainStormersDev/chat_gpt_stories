import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gpt_chat_stories/controllers/musicController.dart';
import 'package:gpt_chat_stories/model/StoryCategoryModels.dart';
import 'package:gpt_chat_stories/utils/mySnackBar.dart';
import '../../common/headers.dart';
import '../../controllers/CreateStoryController.dart';
import '../../utils/MyRepo.dart';
import '../../utils/app_color.dart';
import '../../utils/my_indicator.dart';
import '../Widgets/constWidgets.dart';

class NewStoryCreate extends StatefulWidget {
  final List<StoryCatData> catData;

  NewStoryCreate({Key? key, required this.catData}) : super(key: key);

  @override
  State<NewStoryCreate> createState() => _NewStoryCreateState();
}

class _NewStoryCreateState extends State<NewStoryCreate> {
  CreateStoryController controller = Get.put(CreateStoryController());
  bool _isExpanded = false;
  // GlobalKey<ExpansionTileState> expansionTileKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    logger.i(controller.state.value);

    return Scaffold(
      // backgroundColor: AppColors.kScreenColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: storyByGptWidget(context),
        centerTitle: true,
        backgroundColor: AppColors.kBackgroundTopColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: InkWell(
            onTap: () async {
              try {
                if (MyRepo.musicMuted.value == false) {
                  BackgroundMusicManager().resumeMusic();
                }
              } catch (t) {
                //mp3 unreachable
              }
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.txtColor1,
            ),
          ),
        ),
      ),
      body: Obx(
        () => Container(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: controller.state.value == ApiState.loading
                ? Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/PNG/giphy2.gif",
                            height: 125.0,
                            width: 125.0,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 250.0,
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Bobbers',
                                  color: AppColors.kBtnColor),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  TyperAnimatedText('Please wait ....',
                                      textStyle: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "BalooBhai",
                                        color: AppColors.kBtnColor,
                                      )),
                                  TyperAnimatedText(
                                      'While your story of ${controller.searchTextController.text} is creating...',
                                      textStyle: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "BalooBhai",
                                        color: AppColors.kBtnColor,
                                      )),
                                ],
                                onTap: () {
                                  print("Tap Event");
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Create Your Own Story",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "BalooBhai",
                                color: AppColors.txtColor1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isCatSearch.value = !isCatSearch.value;
                              });
                            },
                            child: Container(

                              padding: EdgeInsets.symmetric(horizontal: 10),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFFDDFE9),
                                      Color(0xFFB6E7F1),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              height: 50,
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "BalooBhai",
                                  color: AppColors.txtColor1,

                                ),
                                controller: controller.searchTextController,
                                decoration: InputDecoration(
                                  hintText: 'Write Story Title..',

                                  hintStyle: TextStyle(
                                  fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: "BalooBhai",
                                    color: AppColors.hintTextColor,),
                                  border: InputBorder.none,
                                  // Remove the default border
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ),

                          // Container(
                          //   width: double.infinity,
                          //   padding: const EdgeInsets.symmetric(horizontal: 16),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(8),
                          //     border: Border.all(color: Colors.grey, width: 1),
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: TextField(
                          //       controller: controller.searchTextController,
                          //       decoration: InputDecoration(
                          //         hintText: 'Story Title..',
                          //         hintStyle: TextStyle(color: AppColors.kGrey),
                          //         border: InputBorder.none,
                          //         // Remove the default border
                          //         contentPadding: EdgeInsets.zero,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 20),
                         if(widget.catData.isNotEmpty)
                          classWidget(widget.catData),

                        ],
                      ),




                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: Get.width,
                          child: FloatingActionButton(
                            backgroundColor: AppColors.kBtnColor,
                            onPressed: () async {
                              if (controller.selectedCategoryId != null &&
                                  controller
                                      .searchTextController.text.isNotEmpty) {
                                controller.state.value = ApiState.loading;
                                setState(() {});
                                await controller.createStory();
                                setState(() {});
                                try {
                                  BackgroundMusicManager().pauseMusic();
                                } catch (t) {}
                              } else {
                                MySnackBar.snackBarRed(
                                    title: 'Error',
                                    message: 'Please add title and category');
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              child: Center(
                                  child: Text(
                                'Create Story',
                                style: TextStyle(fontSize: 20),
                              )),

                              // const Icon(
                              //   Icons.create,
                              // )
                            ),
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
}

classWidget(List<StoryCatData>? catData) {
  return Column(
    children: [
      Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(bottom: 10),

      ),
      ClassListViewWidget(
        catData: catData,

      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}

class ClassListViewWidget extends StatefulWidget {

  List<StoryCatData>? catData;
  ClassListViewWidget({Key? key, this.catData}) : super(key: key);

  @override
  _ClassListViewWidgetState createState() => _ClassListViewWidgetState();
}

class _ClassListViewWidgetState extends State<ClassListViewWidget> {

  CreateStoryController controller = Get.put(CreateStoryController());

  final TextEditingController _classSearchController = TextEditingController();
  // RxBool isCatSearchisClassSearch = false.obs;
  String _searchClassText = "";
  late DateTime _chosenDateTime;

  _ClassListViewWidgetState(){
    _classSearchController.addListener(() {
      if (_classSearchController.text.isEmpty) {
        setState(() {
          _searchClassText = "";
        });
      } else {
        setState(() {
          _searchClassText = _classSearchController.text.trim();
        });
      }
    });
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isCatSearch.value = !isCatSearch.value;
              });
            },
            child: Container(

              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFDDFE9),
                      Color(0xFFB6E7F1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      controller.selectedCategory==null || controller.selectedCategory!.isEmpty?
                      "Select Category":
                      controller.selectedCategory.toString()
                      ,  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: "BalooBhai",
                      color:
                      controller.selectedCategory==null || controller.selectedCategory!.isEmpty
                      ?

                      AppColors.hintTextColor
                      : AppColors.txtColor1
                          ,
                    ),),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Icon(
                      isCatSearch.value
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color:
                      isCatSearch.value
                          ?AppColors.kGirlBGColor
                          :AppColors.kBtnColor,

                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          ),

          isCatSearch.value ?
          Container(
              height: 300,
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              decoration: BoxDecoration(

                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFDDFE9),
                        Color(0xFFB6E7F1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),

                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [

                  SizedBox(
                    height: 10,
                  ),
                  Expanded(child:

                    Container(
                        // height: MediaQuery.of(context).size.height,


                        child:
                        listview(storyCatData: widget.catData!)

                    )
                  )
                ],
              )
          )
              :
          Container(),
        ],
      );
    });
  }

  Widget listview( {required List<StoryCatData> storyCatData, }){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: storyCatData.length,
      itemBuilder:
          (BuildContext context,
          int index) {
        return InkWell(
          onTap: () {
            setState(() {
              isCatSearch.value=false;
              controller.selectedCategory= storyCatData[index].title.toString();
              controller.selectedCategoryId= storyCatData[index].id.toString();

            });

          },
          child: Container(
              decoration: BoxDecoration(
                  // color: AppColors.kBackgroundTopColor,
                  borderRadius:
                  BorderRadius
                      .circular(
                      10)),
              padding:
              EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10),
              margin:
              EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 5),
              child: new Text(
                  storyCatData[index].title.toString(),
                  style: TextStyle(
                      color: AppColors
                          .txtColor1,
                    fontFamily: "BalooBhai",
                  ))),
        );
      },
    );
  }

}