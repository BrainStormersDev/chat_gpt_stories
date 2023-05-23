import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
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
    print("=======select 1 :${MyRepo.selectedGender.name} ====");
    return Scaffold(
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
      backgroundColor: AppColors.kScreenColor,
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                    itemCount: MyRepo.selectAgeList.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){

                  return ageItem(imageUrl: MyRepo.selectAgeList[index].assetImage,ageLimit: MyRepo.selectAgeList[index].age,index: index);

                }),
                // InkWell(
                //   onTap: (){
                //     setState(() {
                //       MyRepo.selectAge=AgeSelect.two;
                //
                //     });
                //     nextPage();
                //
                //
                //
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //         border:MyRepo.selectAge==AgeSelect.two? Border.all(color:AppColors.kPrimary,width: 5 ):null,
                //         color:MyRepo.selectAge==AgeSelect.two ? AppColors.kPrimary:null,
                //         borderRadius: BorderRadius.circular(10)
                //
                //     ),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         InkWell(
                //           onTap: (){
                //             setState(() {
                //               MyRepo.selectAge=AgeSelect.two;
                //
                //             });
                //             nextPage();
                //
                //
                //           },
                //           child: Container(
                //             height: 60,
                //             width: 110,
                //             decoration: ShapeDecoration(
                //               color: MyRepo.selectAge==AgeSelect.two ?AppColors.kPrimary:null,
                //                 shape: polygonAgeContainer(bordColor:MyRepo.selectAge==AgeSelect.two?AppColors.kWhite:AppColors.txtColor1)
                //
                //             ),
                //             child:  Center(
                //               child: Text(
                //                 "1 - 3",
                //                 style: TextStyle(
                //                     fontSize: 30,
                //                     fontWeight: FontWeight.bold,
                //                     fontFamily: "BalooBhai",
                //                     color: MyRepo.selectAge==AgeSelect.two?AppColors.kWhite:AppColors.txtColor1),
                //               ),
                //             ),
                //           ),
                //         ),
                //         Image.asset("assets/PNG/age1-3.png", scale: 0.9,),
                //       ],
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 15,),
                // InkWell(
                //   onTap: (){
                //     setState(() {
                //       MyRepo.selectAge=AgeSelect.four;
                //
                //     });
                //     nextPage();
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //         border:MyRepo.selectAge==AgeSelect.four? Border.all(color:AppColors.kPrimary,width: 5 ):null,
                //         color:MyRepo.selectAge==AgeSelect.four ? AppColors.kPrimary:null,
                //       borderRadius: BorderRadius.circular(10)
                //
                //     ),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         Container(
                //           height: 60,
                //           width: 110,
                //           decoration: ShapeDecoration(
                //               color:MyRepo. selectAge==AgeSelect.four ?AppColors.kPrimary:null,
                //               shape: polygonAgeContainer(bordColor:MyRepo.selectAge==AgeSelect.four?AppColors.kWhite:AppColors.txtColor1)),
                //           child:  Center(
                //             child: Text(
                //               "3 - 5",
                //               style: TextStyle(
                //                   fontSize: 30,
                //                   fontWeight: FontWeight.bold,
                //                   fontFamily: "BalooBhai",
                //                   color:MyRepo. selectAge==AgeSelect.four?AppColors.kWhite:AppColors.txtColor1),
                //             ),
                //           ),
                //         ),
                //         Image.asset("assets/PNG/age3-5.png", scale: 0.9,),
                //       ],
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 15,),
                // InkWell(
                //   onTap: (){
                //     setState(() {
                //       MyRepo. selectAge=AgeSelect.seven;
                //
                //     });
                //     nextPage();
                //
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //         border:MyRepo.selectAge==AgeSelect.seven? Border.all(color:AppColors.kPrimary,width: 5 ):null,
                //         color:MyRepo.selectAge==AgeSelect.seven ? AppColors.kPrimary:null,
                //         borderRadius: BorderRadius.circular(10)
                //
                //     ),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         Container(
                //           height: 60,
                //           width: 110,
                //           decoration: ShapeDecoration(
                //             color: MyRepo.selectAge==AgeSelect.seven ?AppColors.kPrimary:null,
                //               shape: polygonAgeContainer(bordColor:MyRepo.selectAge==AgeSelect.seven?AppColors.kWhite:AppColors.txtColor1)),
                //           child:  Center(
                //             child: Text(
                //               "5 - 10",
                //               style: TextStyle(
                //                   fontSize: 30,
                //                   fontWeight: FontWeight.bold,
                //                   fontFamily: "BalooBhai",
                //                   color: MyRepo.selectAge==AgeSelect.seven?AppColors.kWhite:AppColors.txtColor1),
                //             ),
                //           ),
                //         ),
                //         Image.asset("assets/PNG/age5-10.png", scale: 0.9,),
                //       ],
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 15,),
                // InkWell(
                //   onTap: (){
                //     setState(() {
                //       MyRepo.selectAge=AgeSelect.thirteen;
                //
                //     });
                //     nextPage();
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //         border:MyRepo.selectAge==AgeSelect.thirteen? Border.all(color:AppColors.kPrimary,width: 5 ):null,
                //         color:MyRepo.selectAge==AgeSelect.thirteen ? AppColors.kPrimary:null,
                //         borderRadius: BorderRadius.circular(10)
                //
                //     ),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         Container(
                //           height: 60,
                //           width: 110,
                //           decoration: ShapeDecoration(
                //               color:MyRepo. selectAge==AgeSelect.thirteen ?AppColors.kPrimary:null,
                //               shape: polygonAgeContainer(bordColor:MyRepo.selectAge==AgeSelect.thirteen?AppColors.kWhite:AppColors.txtColor1)),
                //           child:  Center(
                //             child: Text(
                //               "10 +",
                //               style: TextStyle(
                //                   fontSize: 30,
                //                   fontWeight: FontWeight.bold,
                //                   fontFamily: "BalooBhai",
                //                   color: MyRepo.selectAge==AgeSelect.thirteen?AppColors.kWhite:AppColors.txtColor1),
                //             ),
                //           ),
                //         ),
                //         Image.asset("assets/PNG/age10.png", scale: 0.9,),
                //       ],
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 35,),
                const SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: (){
                      if(selectItems.value=='-1'){
                        MySnackBar.snackBarYellow(
                            title:"Alert", message:"Please select Age limit");

                      }else{
                        nextPage(age: MyRepo.selectAgeList[int.parse(selectItems.value)].age);
                      }

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
        )
      ),
    );
  }

  nextPage({required String age}){
    final box =GetStorage();
    box.write(kAge, age);
    box.write(kGender,  MyRepo.selectedGender.name);
    box.write(kTokenStorage, MyRepo.deviceToken.value);
    registrationController.getRegistration(age: age, token: MyRepo.deviceToken.value,gender: MyRepo.selectedGender.name);
    Future.delayed(const Duration(milliseconds: 100), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => StoryCategoryPage()));
    });
  }

  Widget ageItem({required String ageLimit,required String imageUrl,required int index}){

    return Obx(()=>InkWell(
      onTap: (){
        selectItems.value =index.toString();
        // nextPage(age: ageLimit);
        // setState(() {
        //   MyRepo.selectAge=AgeSelect.thirteen;
        //
        // });
        // nextPage();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            border:int.parse(selectItems.value.toString())==index? Border.all(color:AppColors.kPrimary,width: 5 ):null,
            color:int.parse(selectItems.value.toString())==index? AppColors.kPrimary:null,
            borderRadius: BorderRadius.circular(10)

        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 60,
              width: 110,
              decoration: ShapeDecoration(
                  color:int.parse(selectItems.value.toString())==index?AppColors.kPrimary:null,
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
    ));
  }

}
