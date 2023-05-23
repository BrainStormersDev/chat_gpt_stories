import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chat_gpt_stories/model/StoryCategoryModels.dart';
import 'package:chat_gpt_stories/utils/MyRepo.dart';
import 'package:chat_gpt_stories/view/Pages/story_catList_page.dart';
import 'package:chat_gpt_stories/view/Widgets/constWidgets.dart';
import 'package:chat_gpt_stories/view/Widgets/settingsDialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/headers.dart';
import '../../controllers/chat_text_controller.dart';
import '../../controllers/story_cat_controller.dart';
import '../../utils/app_color.dart';
import '../../utils/my_indicator.dart';

class StoryCategoryPage extends StatefulWidget {
  @override
  State<StoryCategoryPage> createState() => _StoryCategoryPageState();
}

class _StoryCategoryPageState extends State<StoryCategoryPage> {
  // ChatImageController controller= Get.put(ChatImageController());

  RxString selectItems = "-1".obs;
  // List<String> gender = ['Boy', 'Girl'];

  final TextEditingController _searachController = TextEditingController();
  StoryCatController storyCatController = Get.put(StoryCatController());
  // List<IconOfStory> title=[IconOfStory(title: "Animals",url: "assets/PNG/storyLion.png",value: "Story of Animals for children"),IconOfStory(title: "Fairy",url: "assets/PNG/storyFairy.png",value: "Fairy Story for children"),IconOfStory(title: "Jeannie",url: "assets/PNG/storyJeannie.png",value: " Jeannie Story for children"),IconOfStory(title: "Hero",url: "assets/PNG/storyHero.png",value: "Story of hero for children"),IconOfStory(title: "Prince",url: "assets/PNG/storyprince.png",value: "Story of prince for children"),IconOfStory(title: "Toy Story",url: "assets/PNG/storyToy.png",value: "Toy Story for children"),IconOfStory(title: "Princes",url: "assets/PNG/storyPrinces.png",value: "Princes Story for children")];
  // List<IconOfStory> title=[IconOfStory(title: "Animals",url: "assets/PNG/storyLion.png",value: "Story of Animals for${GetStorage().read(kGender)} children"),IconOfStory(title: "Fairy",url: "assets/PNG/storyFairy.png",value: "Fairy Story for  ${GetStorage().read(kGender)} children"),IconOfStory(title: "Jeannie",url: "assets/PNG/storyJeannie.png",value: " Jeannie Story for  ${GetStorage().read(kGender)} children"),IconOfStory(title: "Hero",url: "assets/PNG/storyHero.png",value: "Story of hero for  ${GetStorage().read(kGender)} children"),IconOfStory(title: "Prince",url: "assets/PNG/storyprince.png",value: "Story of prince for  ${GetStorage().read(kGender)} children"),IconOfStory(title: "Toy Story",url: "assets/PNG/storyToy.png",value: "Toy Story for  ${GetStorage().read(kGender)} children"),IconOfStory(title: "Princes",url: "assets/PNG/storyPrinces.png",value: "Princes Story for  ${GetStorage().read(kGender)} children")];
  // List<IconOfStory> title=[IconOfStory(title: "Animals",url: "assets/PNG/storyLion.png",value: "Story of Animals for${GetStorage().read(kGender)} ${GetStorage().read(kAge)} years old"),IconOfStory(title: "Fairy",url: "assets/PNG/storyFairy.png",value: "Fairy Story for  ${GetStorage().read(kGender)} ${GetStorage().read(kAge)} years old"),IconOfStory(title: "Jeannie",url: "assets/PNG/storyJeannie.png",value: " Jeannie Story for  ${GetStorage().read(kGender)} ${GetStorage().read(kAge)} years old"),IconOfStory(title: "Hero",url: "assets/PNG/storyHero.png",value: "Story of hero for  ${GetStorage().read(kGender)} ${GetStorage().read(kAge)} years old"),IconOfStory(title: "Prince",url: "assets/PNG/storyprince.png",value: "Story of prince for  ${GetStorage().read(kGender)} ${GetStorage().read(kAge)} years old"),IconOfStory(title: "Toy Story",url: "assets/PNG/storyToy.png",value: "Toy Story for  ${GetStorage().read(kGender)} ${GetStorage().read(kAge)} years old"),IconOfStory(title: "Princes",url: "assets/PNG/storyPrinces.png",value: "Princes Story for  ${GetStorage().read(kGender)} ${GetStorage().read(kAge)} years old")];
  // const StoryCategoryPage({Key? key}) : super(key: key);
  // RxBool isMuted = false.obs;

  @override
  void initState() {
    // TODO: implement initState

    var mute=GetStorage().read(kMute);
    if(mute!=null){
      MyRepo.musicMuted.value=mute;
    }

    print("========repo muted value init  =${GetStorage().read(kMute)}");
    // MyRepo.musicMuted.value = GetStorage().read(kMute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("========repo muted value  =${GetStorage().read(kMute)}");
    print("========selectedGender  =${MyRepo.selectedGender.name}");
    return Scaffold(
        backgroundColor: AppColors.kScreenColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 40,
          elevation: 0,
          backgroundColor: AppColors.kScreenColor,
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
            onPressed: () async {
              MyRepo.assetsAudioPlayer.stop();
              Navigator.pop(context);
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  storyByGptWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "I want to listen a story about",
                      style:
                          TextStyle(color: AppColors.txtColor2, fontSize: 21),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // TextField(
                  //   controller: _searachController,
                  //   onSubmitted: (value) {
                  //     nextPage(data:StoryCatData(title: _searachController.text,imageUrl: []));
                  //   },
                  //   onChanged: (value){
                  //     // searchData(st = value.trim().toLowerCase());
                  //     // Method For Searching
                  //   },
                  //   decoration:  InputDecoration(
                  //     hintText: "Search Story...",
                  //     hintStyle: TextStyle(color: AppColors.kPrimary),
                  //     suffixIcon: InkWell(
                  //         onTap: (){
                  //
                  //           print("======searacb ${_searachController.text}=====");
                  //           nextPage(data:StoryCatData(title: _searachController.text,imageUrl: []));
                  //         },
                  //
                  //         child: const Icon(Icons.search,color: AppColors.kPrimary,size: 40,)),
                  //     enabledBorder: const OutlineInputBorder(
                  //       borderSide: BorderSide(color: AppColors.kPrimary, width: 2.0),
                  //     ),
                  //     border: const OutlineInputBorder(
                  //
                  //       borderRadius:
                  //       BorderRadius.all(Radius.circular(7.0),),
                  //     ),
                  //   ),
                  // ),
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
                                  child:
                                      Text(storyCatController.errorMsg.value))
                              : GridView.count(
                                  childAspectRatio: 0.8,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 8.0,
                                  shrinkWrap: true,
                                  children: List.generate(
                                      storyCatController.storyCategoryModels
                                          .value.data!.length, (index) {
                                    return icon(
                                        data: storyCatController
                                            .storyCategoryModels
                                            .value
                                            .data![index],
                                        index: index);
                                  }),
                                ),
                        ),

                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Image.asset("assets/PNG/storyLion.png"),
                  //           const Text(
                  //             "Animals",
                  //             style: TextStyle(
                  //                 fontSize: 15,
                  //                 fontWeight: FontWeight.bold,
                  //                 fontFamily: "BalooBhai",
                  //                 color: AppColors.txtColor1),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Image.asset("assets/PNG/storyFairy.png"),
                  //           const Text(
                  //             "Fairy",
                  //             style: TextStyle(
                  //                 fontSize: 15,
                  //                 fontWeight: FontWeight.bold,
                  //                 fontFamily: "BalooBhai",
                  //                 color: AppColors.txtColor1),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Image.asset("assets/PNG/storyJeannie.png"),
                  //           const Text(
                  //             "Jeannie",
                  //             style: TextStyle(
                  //                 fontSize: 15,
                  //                 fontWeight: FontWeight.bold,
                  //                 fontFamily: "BalooBhai",
                  //                 color: AppColors.txtColor1),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 20,),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Image.asset("assets/PNG/storyHero.png"),
                  //           const Text(
                  //             "Hero",
                  //             style: TextStyle(
                  //                 fontSize: 15,
                  //                 fontWeight: FontWeight.bold,
                  //                 fontFamily: "BalooBhai",
                  //                 color: AppColors.txtColor1),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Image.asset("assets/PNG/storyprince.png"),
                  //           const Text(
                  //             "Prince",
                  //             style: TextStyle(
                  //                 fontSize: 15,
                  //                 fontWeight: FontWeight.bold,
                  //                 fontFamily: "BalooBhai",
                  //                 color: AppColors.txtColor1),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Image.asset("assets/PNG/storyToy.png"),
                  //           const Text(
                  //             "Toy Story",
                  //             style: TextStyle(
                  //                 fontSize: 15,
                  //                 fontWeight: FontWeight.bold,
                  //                 fontFamily: "BalooBhai",
                  //                 color: AppColors.txtColor1),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 20,),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   // mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     const SizedBox(width: 30,),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Image.asset("assets/PNG/storyPrinces.png"),
                  //         const Text(
                  //           "Princes",
                  //           style: TextStyle(
                  //               fontSize: 15,
                  //               fontWeight: FontWeight.bold,
                  //               fontFamily: "BalooBhai",
                  //               color: AppColors.txtColor1),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 35,),
                  // ElevatedButton(
                  //     onPressed: (){
                  //
                  //
                  //       // Get.to(const AgePage());
                  //
                  //       if(selectItems.value=="-1"){
                  //
                  //         MySnackBar.snackBarRed(
                  //             title:"Alert", message:"Please select story type");
                  //
                  //       }else{
                  //         print("==========value:${title[int.parse(selectItems.value)].value}==========");
                  //         Get.put(ChatImageController()).getGenerateImages(title[int.parse(selectItems.value)].value);
                  //         Get.put(ChatTextController()).getTextCompletion(title[int.parse(selectItems.value)].value);
                  //         Navigator.push(context, MaterialPageRoute(builder: (context) =>  StoryPage(storyType: title[int.parse(selectItems.value)].title,)));
                  //
                  //
                  //       }
                  //       //
                  //     },
                  //     style: ButtonStyle(
                  //         shadowColor:  MaterialStatePropertyAll(AppColors.kBtnShadowColor),
                  //         backgroundColor: const MaterialStatePropertyAll(AppColors.kBtnColor),
                  //         shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
                  //     ),
                  //     child: const SizedBox(
                  //         height: 50,
                  //         // width: MediaQuery.of(context).size.width/2,
                  //         child: Center(
                  //             child: Text("Next",
                  //                 style: TextStyle(color: AppColors.kBtnTxtColor, fontWeight: FontWeight.bold, fontSize: 18))))),
                ],
              ),
            ),
          ),
        ));
  }

  Widget icon({required StoryCatData data, required int index}) {
    return InkWell(
      onTap: () {
        selectItems.value = index.toString();
        print("========data:${selectItems.value}=======");
        // controller.getGenerateImages(data.story);
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


}
