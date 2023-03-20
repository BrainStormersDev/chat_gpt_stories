import 'package:chat_gpt_stories/common/headers.dart';
import 'package:chat_gpt_stories/controllers/chat_text_controller.dart';
import 'package:chat_gpt_stories/model/storyCatListModel.dart';
import 'package:chat_gpt_stories/utils/MyRepo.dart';
import 'package:chat_gpt_stories/utils/app_color.dart';
import 'package:chat_gpt_stories/utils/my_indicator.dart';
import 'package:chat_gpt_stories/view/Widgets/constWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';


import 'story_page.dart';

class StoryCatList extends StatefulWidget {
  final String catName;
  StoryCatList({required this.catName});

  @override
  State<StoryCatList> createState() => _StoryCatListState();
}



class _StoryCatListState extends State<StoryCatList> {

  RxString selectItems="-1".obs;

  final TextEditingController _searachController = TextEditingController();
  ChatTextController storyCatListController =Get.put(ChatTextController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("=============== Data ID: ${storyCatListController.storyCategoryListModels.value.data}");
    return Scaffold(
        backgroundColor: AppColors.kScreenColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 40,
          elevation: 0,
          backgroundColor: AppColors.kScreenColor,
          actions:   [
            InkWell(
                onTap: (){
                  // print("======selectedAge:${selectedAge.value}======");
                  // print("======selectedGender:${selectedGender.value}======");
                  // showCustomDialog( context);
                },
                child: Container(
                    margin: EdgeInsets.only(right:  15.0,top: 10),
                    child: Icon(FontAwesomeIcons.gear ,color: AppColors.kPrimary,))),
          ],
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);

            },

            icon: const Icon(Icons.arrow_back, color: AppColors.txtColor1,), ),

        ),
        body: Obx(()=>Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0,),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                storyByGptWidget(),
                const SizedBox(height: 20,),
                TextField(
                  controller: _searachController,
                  onSubmitted: (value) {
                    // nextPage(data:Data(storyTitle: _searachController.text,images: []));
                  },
                  onChanged: (value){
                    // searchData(st = value.trim().toLowerCase());
                    // Method For Searching
                  },
                  decoration:  InputDecoration(
                    hintText: "Search Story...",
                    hintStyle: const TextStyle(color: AppColors.kPrimary),
                    suffixIcon: InkWell(
                        onTap: (){

                          print("======searacb ${_searachController.text}=====");
                          // nextPage(data:Data(storyTitle: _searachController.text,images: []));
                        },

                        child: const Icon(Icons.search,color: AppColors.kPrimary,size: 40,)),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.kPrimary, width: 2.0),
                    ),
                    border: const OutlineInputBorder(

                      borderRadius:
                      BorderRadius.all(Radius.circular(7.0),),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),

                storyCatListController.state.value == ApiState.loading? myIndicator():  Container(
                  // height: 400,
                  child:storyCatListController.state.value == ApiState.error?
                  Container(child: Center(child: Text(storyCatListController.errorMsg.value)),)
                      : Column(
                    children: List.generate(storyCatListController.storyCategoryListModels.value.data!.length, (index) {
                      return SizedBox(
                        height: 100,
                          child:
                          // Text(storyCatListController.storyCategoryListModels.value.data![index].storyTitle.toString())
                          icon(index)
                      );
                      // return icon(data:storyCatController.storyCategoryModels.value.data![index],index: index);
                    }
                  )
                  ),
                ),
              ],
            ),
          ),
        ),)
    );
  }

  Widget icon(index){
    return InkWell(
      // onTap: (){
      //   selectItems.value = index.toString();
      //   print("========data:${selectItems.value }=======");
      //   // controller.getGenerateImages(data.story);
      //   // nextPage(data: data);
      //   // nextPage(title: title[int.parse(selectItems.value)].title);
      //
      // },
      child: Container(
        decoration: const BoxDecoration(
            // color: Colors.green,
            // color:int.parse(selectItems.value.toString())==index? AppColors.kPrimary:null,
            // border:int.parse(selectItems.value.toString())==index? Border.all(color: AppColors.kBtnColor):null,
        ),
        child: Card(
          color:int.parse(selectItems.value.toString())==index? AppColors.kPrimary:null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/PNG/img_4.png"), fit: BoxFit.fitWidth),
                  borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(20), bottomStart: Radius.circular(20)),
                  color: Colors.red,
                ),

                height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.height * 0.15,
                  // child: storyCatListController.storyCategoryListModels.value.data![index].images![index].imageUrl == "" ? const SizedBox() :
                  // Image.network(storyCatListController.storyCategoryListModels.value.data![index].images!.first.imageUrl.toString())
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.07,),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.catName,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "BalooBhai",
                                  color: int.parse(selectItems.value.toString())==index?AppColors.txtColor1: Colors.grey)
                          ),
                        ),
                        // SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                        Text("days ago",
                            style: TextStyle(
                            fontSize: 13,
                            fontFamily: "BalooBhai",
                            color: int.parse(selectItems.value.toString())==index?AppColors.txtColor1: Colors.grey)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            // "Large Title here The Story",
                            storyCatListController.storyCategoryListModels.value.data![index].storyTitle.toString(),
                            style:  TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "DMSerifDisplayRegular",
                                color:int.parse(selectItems.value.toString())==index?AppColors.kWhite: AppColors.txtColor1),
                          ),
                        ),
                        // SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                        GestureDetector(
                          onTap: (){
                            selectItems.value = index.toString();
                            nextPage(data: storyCatListController.storyCategoryListModels.value.data![index]);
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: int.parse(selectItems.value.toString())==index?AppColors.kWhite : AppColors.kBtnColor,
                            child: const Center(child: Icon(CupertinoIcons.play_arrow_solid, color: AppColors.txtColor1, size: 20,)),
                          ),
                        ),
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
  nextPage({required DataList data}) async {


    String searchText ='';
    String categId =data.id.toString();
    // String searchText ='${data.storyTitle}';
    // String searchText ='${data.title}';
    // String searchText ='Story of ${data.title} for children';


    await MyRepo.assetsAudioPlayer.pause();

    Future.delayed(const Duration(milliseconds: 100), () {
      // print("==========value:${searchText },$title==========");
      // Get.put(ChatTextController()).getTextCompletion(query: searchText, catId: categId);
      // Get.put(ChatImageController()).getGenerateImages(searchText);
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  StoryPage(data:data,)));
    });
  }





}
