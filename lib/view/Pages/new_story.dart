import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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

  @override
  Widget build(BuildContext context) {
    // logger.i(GetStorage().read("bearerToken"));

    return Scaffold(
      backgroundColor: AppColors.kScreenColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: storyByGptWidget(context),
        centerTitle: true,
        backgroundColor: AppColors.kScreenColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // Get.close(1);
            // Get.off(()=>StoryViewPage(data: MyRepo.currentStory));
          },
          icon: InkWell(
            onTap: () async {
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
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.txtColor1,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child:
        controller.state.value == ApiState.loading
        ?
            Center(child: myIndicator(),):

        Stack(
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
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.searchTextController,
                      decoration: InputDecoration(
                        hintText: 'Story Title..',
                        hintStyle: TextStyle(color: AppColors.kGrey),
                        border: InputBorder.none, // Remove the default border
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.dropDownColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        widget.catData.isNotEmpty
                            ? Expanded(
                                child: Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 16),
                                  child: DropdownButton<String>(
                                    value: controller.selectedCategory,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        controller.selectedCategory = newValue!;
                                      });
                                    },
                                    underline: SizedBox(),
                                    // Remove the default underline
                                    icon: SizedBox.shrink(),
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: null,
                                        child: Text('Category', style: TextStyle(color: AppColors.kGrey),),
                                      ),
                                      ...widget.catData
                                          .map<DropdownMenuItem<String>>(
                                        (StoryCatData category) {
                                          return DropdownMenuItem<String>(
                                            onTap: () {
                                              controller.selectedCategoryId =
                                                  category.id.toString();
                                            },
                                            value: category.title.toString(),
                                            child:
                                                Text(category.title.toString()),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
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
                        controller.searchTextController.text.isNotEmpty) {
                      controller.state.value = ApiState.loading;
                      setState(() {

                      });
                      try {

                        await MyRepo.assetsAudioPlayer.pause();
                      }
                      catch (t) {
                        //mp3 unreachable
                      }
                      await controller.createStory();
                      // controller.searchTextController.clear();
                      // controller.selectedCategoryId = null;
                    } else {
                      MySnackBar.snackBarRed(
                          title: 'Error',
                          message: 'Please add title and category');
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    child: Center(
                        child:


                        Text(
                          'Create Story',
                          style: TextStyle(fontSize: 20),
                        )
                  ),

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
    );
  }
}
