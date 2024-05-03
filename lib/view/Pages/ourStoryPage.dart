import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt_chat_stories/utils/categoryImages.dart';
import 'package:gpt_chat_stories/view/Pages/story_catList_page.dart';

import '../../common/headers.dart';
import '../../controllers/getStoriesController.dart';
import '../../controllers/story_cat_controller.dart';
import '../../model/StoryCategoryModels.dart';
import '../../utils/MyRepo.dart';
import '../../utils/app_color.dart';
import '../../utils/my_indicator.dart';

class OurMainCatStories extends StatefulWidget {
  const OurMainCatStories({super.key});

  @override
  State<OurMainCatStories> createState() => _OurMainCatStoriesState();
}

class _OurMainCatStoriesState extends State<OurMainCatStories> {
  StoryCatController storyCatController = Get.put(StoryCatController());
  RxString selectItems = "-1".obs;
  @override
  Widget build(BuildContext context) {
    return
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
                      ?
                  Center(
                      child: Text(
                          "Oops.. Something bad happen!",
                       style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bobbers',
                            color: AppColors.txtColor1
                        ),
                      ))
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
                          image:catImages[index],
                          title:catTitle[index],
                          index: index);
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      });
  }
  Widget icon({
    required StoryCatData data,
    required int index,
    required String image,
    required String title,
  }) {
    print(data.imageUrl);
    return InkWell(
      onTap: () {
        selectItems.value = index.toString();

        MyRepo.storyCat = title;
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
            Container(
              height:80,
              width: 80,
              child: CachedNetworkImage(
                imageUrl: data.imageUrl!,
                placeholder: (context, url) =>
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              image,
                            ),
                            // fit: BoxFit.fill
                        ),
                      ),
                    ),
                errorWidget: (context, url, error) => Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          image,
                        ),
                        // fit: BoxFit.fill
                    ),
                  ),
                ),

              ),
            ),
            Expanded(
              child: Text(
                title,
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


}
