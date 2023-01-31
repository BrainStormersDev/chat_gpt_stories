import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_gpt_stories/view/Pages/rate_us_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../common/headers.dart';
import '../../controllers/chat_image_controller.dart';
import '../../controllers/chat_text_controller.dart';
import '../../utils/app_color.dart';

class StoryViewPage extends StatefulWidget {
  const StoryViewPage({Key? key}) : super(key: key);

  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  ChatImageController controllerImage= Get.put(ChatImageController());
  ChatTextController controllerText= Get.put(ChatTextController());
  @override
  Widget build(BuildContext context) {
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
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RateUsPage()));
              },
              icon: const Icon(CupertinoIcons.star, color: AppColors.kBtnColor,))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 27,
                      child: Image.asset("assets/PNG/gridIcon.png")),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                  const Text(
                    "Story ",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      // height: MediaQuery.of(context).size.height * 0.1,
                      // width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.kBtnColor, width: 1)
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 4, bottom: 4, right: 8),
                        child: Text(
                          "Cinderella ",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: "BalooBhai",
                              color: AppColors.kBtnColor),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //     height: MediaQuery.of(context).size.height * 0.12,
                  //     child: Image.asset("assets/PNG/loin.png")),
                ],
              ),
            Expanded(
              child: ListView.builder(

                itemCount:controllerImage.images.length-1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text(
                        controllerText.messages[0].text,
                        // "It is a long established fact that a reader will be distracted",
                        style: TextStyle(color: AppColors.txtColor2, fontSize: 17),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 10,),
                      controllerImage.state.value == ApiState.loading
                          ? const CircularProgressIndicator()
                          :Card(
                        child: CachedNetworkImage(
                          imageUrl: controllerImage.images.isEmpty?"":controllerImage.images[index+1].url,
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
                    ],
                  );
                }),
            ),



              // SizedBox(
              //     // height: MediaQuery.of(context).size.height * 0.4,
              //     child: Image.asset("assets/PNG/img.png")),
              // const SizedBox(height: 10,),
              // Text(
              //   "by the readable content of a page when looking at its layout.",
              //   style: TextStyle(color: AppColors.txtColor2, fontSize: 17),
              //   textAlign: TextAlign.start,
              // ),
              // const SizedBox(height: 10,),
              // SizedBox(
              //   // height: MediaQuery.of(context).size.height * 0.4,
              //     child: Image.asset("assets/PNG/img_1.png")),
              // const SizedBox(height: 10,),
              // Text(
              //   "dable English. Many desktop publishing ",
              //   style: TextStyle(color: AppColors.txtColor2, fontSize: 17),
              //   textAlign: TextAlign.start,
              // ),
              // const SizedBox(height: 10,),
              // SizedBox(
              //   // height: MediaQuery.of(context).size.height * 0.4,
              //     child: Image.asset("assets/PNG/img_2.png")),
              // const SizedBox(height: 35,),
            ],
          ),
        ),
      ),
    );;
  }
}
