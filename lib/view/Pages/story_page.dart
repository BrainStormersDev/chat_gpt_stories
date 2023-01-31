import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_gpt_stories/view/Pages/story_view_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';


import '../../controllers/chat_image_controller.dart';
import '../../utils/app_color.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatImageController controller= Get.put(ChatImageController());


    RxString abc=''.obs;
    return Scaffold(
      backgroundColor: AppColors.kScreenColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.kScreenColor,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);

          },
          icon: const Icon(Icons.arrow_back, color: AppColors.txtColor1,), ),
      ),
      body:SafeArea(
        child: Obx(()=>Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.06,
                // ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 27,
                        child: Image.asset("assets/PNG/gridIcon.png")),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                     Text(
                      "Story ${abc.value}",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: "BalooBhai",
                          color: AppColors.kBtnColor),
                    ),
                    const Text(
                      "By Chat GPT",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: "BalooBhai",

                          color: AppColors.txtColor1),
                    ),
                    const Spacer(),
                    SizedBox(
                        height: 30,
                        child: Image.asset("assets/PNG/bellIcon.png")),
                  ],
                ),
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
                const SizedBox(height: 20,),
                InkWell(
                  onTap: (){

                    controller.getGenerateImages("Prince Story");

                  },
                  child: Card(
                    child: CachedNetworkImage(
                      imageUrl: controller.images.isEmpty?"":controller.images[0].url,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          SizedBox(
                              height: 150,
                              width: 150,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(.3),
                                highlightColor: Colors.grey,
                                child: Container(
                                  height: 220,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                              )),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.asset("assets/PNG/storyImg.png")),
                const SizedBox(height: 35,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:  [
                    IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.skip_previous_rounded, color: AppColors.kBtnColor, size: 30,)),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const StoryViewPage()));
                      },
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.kBtnColor,
                        child: Icon(CupertinoIcons.play_arrow_solid, color: AppColors.txtColor1,),
                      ),
                    ),
                    IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.skip_next_rounded, color: AppColors.kBtnColor, size: 30,)),

                  ],
                ),
                // ElevatedButton(
                //     onPressed: (){
                //       // Get.to(const AgePage());
                //       // Navigator.push(context, MaterialPageRoute(builder: (context) => const AgePage()));
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
        )),
      ),
    );
  }
}
