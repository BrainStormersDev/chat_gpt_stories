// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/chat_image_controller.dart';
import '../../controllers/registration_controller.dart';
import '../../main.dart';
import '../../model/IconModels.dart';
import '../../utils/MyRepo.dart';
import '../../utils/app_color.dart';
import '../../utils/mySnackBar.dart';
import '../Widgets/polygon_Container.dart';
import 'gender_page.dart';
import 'story_category_page.dart';
class AgePage extends StatefulWidget {
  const AgePage({Key? key}) : super(key: key);

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {


  RegistrationController registrationController =Get.put(RegistrationController());
  RxString selectItems="-1".obs;

  @override
  Widget build(BuildContext context) {
    print(" select 1 :${MyRepo.selectedGender.name}");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.kBackgroundTopColor,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);

          },
          icon: const Icon(Icons.arrow_back, color: AppColors.txtColor1,), ),
      ),
      backgroundColor: AppColors.kScreenColor,
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
        child: Padding(
          padding: const EdgeInsets.only(top:50.0,
            left:20,
            right:20,

          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text(
                      "Story ",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "BalooBhai",
                          color: AppColors.kBtnColor),
                    ),
                    Text(
                      "By GPT",
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
                Row(
                  children: const [
                    // SizedBox(width: 20,),
                    Text(
                      "My Age is",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "BalooBhai",
                          color: AppColors.txtColor1),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),


                ListView.builder(
                    itemCount:
                    MyRepo.selectedGender.name=="Girl"
                    ?
                    MyRepo.selectGirlAgeList.length
                        :
                    MyRepo.selectBoyAgeList.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){

                  return ageItem(imageUrl:
                  MyRepo.selectedGender.name=="Girl"
                      ?
                  MyRepo.selectGirlAgeList[index].assetImage
                      :
                  MyRepo.selectBoyAgeList[index].assetImage,
                      ageLimit:
                      MyRepo.selectedGender.name=="Girl"
                          ?
                  MyRepo.selectGirlAgeList[index].age
                      :
                  MyRepo.selectBoyAgeList[index].age


                      ,index: index);

                }),
                const SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: (){
                      if(selectItems.value=='-1'){
                        MySnackBar.snackBarYellow(
                            title:"Alert", message:"Please select Age limit");

                      }else{
                        nextPage(age: MyRepo.selectBoyAgeList[int.parse(selectItems.value)].age);
                      }

                    },
                    style: ButtonStyle(
                        shadowColor:  MaterialStatePropertyAll(AppColors.kBtnShadowColor),
                        backgroundColor:  MaterialStatePropertyAll(AppColors.kBtnColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
                    ),
                    child:  SizedBox(
                        height: 50,
                        // width: MediaQuery.of(context).size.width/2,
                        child: Center(
                            child: Text("Next",
                                style: TextStyle(color: AppColors.kBtnTxtColor, fontWeight: FontWeight.bold, fontSize: 18))))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  nextPage({required String age}){
    final box =GetStorage();
    box.write(kAge, age);
    box.write(kGender,  MyRepo.selectedGender.name);
    box.write(kTokenStorage, MyRepo.deviceToken.value);
    Future.delayed(const Duration(milliseconds: 100), () {
      GetStorage().write("userName",'');
      Navigator.push(context, MaterialPageRoute(builder: (context) => StoryCategoryPage()));
    });
  }

  Widget ageItem({required String ageLimit,required String imageUrl,required int index}){

    return Obx(()=>InkWell(
      onTap: (){
        selectItems.value =index.toString();
      },
      child: Container(

        decoration: BoxDecoration(
            border:int.parse(selectItems.value.toString())==index?
            Border.all(color:AppColors.kBtnColor,width: 5 ):null,
            color:int.parse(selectItems.value.toString())==index? AppColors.kBtnColor:null,
            borderRadius: BorderRadius.circular(10)

        ),
        child: Padding(
          padding: const EdgeInsets.only(left:50.0, right:50,top:10),
          child: Container(
            height: 90,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 60,
                  width: 110,
                  decoration: ShapeDecoration(
                      color:int.parse(selectItems.value.toString())==index?
                      AppColors.kGirlBGColor:null,
                      shape: polygonAgeContainer(bordColor:int.parse(selectItems.value.toString())==index?AppColors.kWhite:AppColors.txtColor1)),
                  child:  Center(
                    child: Text(
                      ageLimit,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "BalooBhai",
                          color: int.parse(selectItems.value.toString())==index?AppColors.kWhite:AppColors.txtColor1),
                    ),
                  ),
                ),
                Image.asset(imageUrl, scale: 0.9,),
              ],
            ),
          ),
        ),
      ),
    ));
  }

}
