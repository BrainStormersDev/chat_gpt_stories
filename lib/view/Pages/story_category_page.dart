import 'package:chat_gpt_stories/controllers/chat_image_controller.dart';
import 'package:chat_gpt_stories/view/Pages/story_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/chat_text_controller.dart';
import '../../model/IconModels.dart';
import '../../utils/app_color.dart';
import '../../utils/mySnackBar.dart';

class StoryCategoryPage extends StatefulWidget {
  @override
  State<StoryCategoryPage> createState() => _StoryCategoryPageState();
}

class _StoryCategoryPageState extends State<StoryCategoryPage> {
  ChatImageController controller= Get.put(ChatImageController());
  RxString selectItems="-1".obs;
  // const StoryCategoryPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    List<IconOfStory> title=[IconOfStory(title: "Animals",url: "assets/PNG/storyLion.png",value: "Story of Animals for children"),IconOfStory(title: "Fairy",url: "assets/PNG/storyFairy.png",value: "Fairy Story for children"),IconOfStory(title: "Jeannie",url: "assets/PNG/storyJeannie.png",value: " Jeannie Story for children"),IconOfStory(title: "Hero",url: "assets/PNG/storyHero.png",value: "Story of hero for children"),IconOfStory(title: "Prince",url: "assets/PNG/storyprince.png",value: "Story of prince for children"),IconOfStory(title: "Toy Story",url: "assets/PNG/storyToy.png",value: "Toy Story for children"),IconOfStory(title: "Princes",url: "assets/PNG/storyPrinces.png",value: "Princes Story for children")];
    return Scaffold(
      backgroundColor: AppColors.kScreenColor,
      body: Obx(()=>SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Story ",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "BalooBhai",
                          color: AppColors.kBtnColor),
                    ),
                    Text(
                      "By Chat GPT",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "BalooBhai",
                          color: AppColors.txtColor1),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "I want to listen a story about",
                    style: TextStyle(color: AppColors.txtColor2, fontSize: 21),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20,),

                Container(
                  height: 400,
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 8.0,
                    shrinkWrap: true,
                    children: List.generate(title.length, (index) {
                      return icon(data:title[index],index: index);
                    }
                    )  ,
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
                ElevatedButton(
                    onPressed: (){
                      // Get.to(const AgePage());
                      
                      if(selectItems.value=="-1"){

                        MySnackBar.snackBarRed(
                            title:"Alert", message:"Please select story type");
                        
                      }else{
                        print("==========value:${title[int.parse(selectItems.value)].value}==========");
                        Get.put(ChatImageController()).getGenerateImages(title[int.parse(selectItems.value)].value);
                        Get.put(ChatTextController()).getTextCompletion(title[int.parse(selectItems.value)].value);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const StoryPage()));
                        
                        
                      }
                      //
                    },
                    style: ButtonStyle(
                        shadowColor:  MaterialStatePropertyAll(AppColors.kBtnShadowColor),
                        backgroundColor: const MaterialStatePropertyAll(AppColors.kBtnColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
                    ),
                    child: const SizedBox(
                        height: 50,
                        // width: MediaQuery.of(context).size.width/2,
                        child: Center(
                            child: Text("Next",
                                style: TextStyle(color: AppColors.kBtnTxtColor, fontWeight: FontWeight.bold, fontSize: 18))))),
              ],
            ),
          ),
        ),
      ),)
    );
  }

  Widget icon({required IconOfStory data, required int index}){
    return InkWell(
      onTap: (){
        selectItems.value =index.toString();
        print("========data:${selectItems.value }=======");
        // controller.getGenerateImages(data.story);

      },
      child: Container(
        decoration: BoxDecoration(border:int.parse(selectItems.value.toString())==index? Border.all(color: AppColors.kBtnColor):null),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(data.url),
             Text(
               data.title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "BalooBhai",
                  color: AppColors.txtColor1),
            ),
          ],
        ),
      ),
    );
  }
}
