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

  @override
  Widget build(BuildContext context) {
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
                InkWell(
                  onTap: (){
                    setState(() {
                      MyRepo.selectAge=AgeSelect.two;

                    });
                    nextPage();



                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border:MyRepo.selectAge==AgeSelect.two? Border.all(color:AppColors.kPrimary,width: 5 ):null,
                        color:MyRepo.selectAge==AgeSelect.two ? AppColors.kPrimary:null,
                        borderRadius: BorderRadius.circular(10)

                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              MyRepo.selectAge=AgeSelect.two;

                            });
                            nextPage();


                          },
                          child: Container(
                            height: 60,
                            width: 110,
                            decoration: ShapeDecoration(
                              color: MyRepo.selectAge==AgeSelect.two ?AppColors.kPrimary:null,
                                shape: polygonAgeContainer(bordColor:MyRepo.selectAge==AgeSelect.two?AppColors.kWhite:AppColors.txtColor1)

                            ),
                            child:  Center(
                              child: Text(
                                "1 - 3",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "BalooBhai",
                                    color: MyRepo.selectAge==AgeSelect.two?AppColors.kWhite:AppColors.txtColor1),
                              ),
                            ),
                          ),
                        ),
                        Image.asset("assets/PNG/age1-3.png", scale: 0.9,),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                InkWell(
                  onTap: (){
                    setState(() {
                      MyRepo.selectAge=AgeSelect.four;

                    });
                    nextPage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border:MyRepo.selectAge==AgeSelect.four? Border.all(color:AppColors.kPrimary,width: 5 ):null,
                        color:MyRepo.selectAge==AgeSelect.four ? AppColors.kPrimary:null,
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
                              color:MyRepo. selectAge==AgeSelect.four ?AppColors.kPrimary:null,
                              shape: polygonAgeContainer(bordColor:MyRepo.selectAge==AgeSelect.four?AppColors.kWhite:AppColors.txtColor1)),
                          child:  Center(
                            child: Text(
                              "3 - 5",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "BalooBhai",
                                  color:MyRepo. selectAge==AgeSelect.four?AppColors.kWhite:AppColors.txtColor1),
                            ),
                          ),
                        ),
                        Image.asset("assets/PNG/age3-5.png", scale: 0.9,),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                InkWell(
                  onTap: (){
                    setState(() {
                      MyRepo. selectAge=AgeSelect.seven;

                    });
                    nextPage();

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border:MyRepo.selectAge==AgeSelect.seven? Border.all(color:AppColors.kPrimary,width: 5 ):null,
                        color:MyRepo.selectAge==AgeSelect.seven ? AppColors.kPrimary:null,
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
                            color: MyRepo.selectAge==AgeSelect.seven ?AppColors.kPrimary:null,
                              shape: polygonAgeContainer(bordColor:MyRepo.selectAge==AgeSelect.seven?AppColors.kWhite:AppColors.txtColor1)),
                          child:  Center(
                            child: Text(
                              "5 - 10",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "BalooBhai",
                                  color: MyRepo.selectAge==AgeSelect.seven?AppColors.kWhite:AppColors.txtColor1),
                            ),
                          ),
                        ),
                        Image.asset("assets/PNG/age5-10.png", scale: 0.9,),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                InkWell(
                  onTap: (){
                    setState(() {
                      MyRepo.selectAge=AgeSelect.thirteen;

                    });
                    nextPage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border:MyRepo.selectAge==AgeSelect.thirteen? Border.all(color:AppColors.kPrimary,width: 5 ):null,
                        color:MyRepo.selectAge==AgeSelect.thirteen ? AppColors.kPrimary:null,
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
                              color:MyRepo. selectAge==AgeSelect.thirteen ?AppColors.kPrimary:null,
                              shape: polygonAgeContainer(bordColor:MyRepo.selectAge==AgeSelect.thirteen?AppColors.kWhite:AppColors.txtColor1)),
                          child:  Center(
                            child: Text(
                              "10 +",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "BalooBhai",
                                  color: MyRepo.selectAge==AgeSelect.thirteen?AppColors.kWhite:AppColors.txtColor1),
                            ),
                          ),
                        ),
                        Image.asset("assets/PNG/age10.png", scale: 0.9,),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 35,),
                ElevatedButton(
                    onPressed: (){
                      if(MyRepo.selectAge==AgeSelect.notSelect){
                        MySnackBar.snackBarYellow(
                            title:"Alert", message:"Please select Age limit");

                      }else{
                        nextPage();
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

  nextPage(){


    final box =GetStorage();
    box.write(kAge, MyRepo.selectAge.name);
    box.write(kGender, MyRepo.selectedGender.name);
    box.write(kTokenStorage, MyRepo.deviceToken.value);



    registrationController.getRegistration(age: MyRepo.selectAge.name, token: MyRepo.deviceToken.value,gender: MyRepo.selectedGender.name);
    Future.delayed(const Duration(milliseconds: 100), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => StoryCategoryPage()));
    });
  }

  Widget ageItem({required IconOfStory data}){

    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: (){
            // controller.getGenerateImages("Pakistan");
            // controller.getTextCompletion("story");
          },
          child: Container(
            height: 60,
            width: 110,
            decoration: ShapeDecoration(
              // color: Colors.red,
                shape: polygonAgeContainer()),
            child: const Center(
              child: Text(
                "1 - 3",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "BalooBhai",
                    color: AppColors.txtColor1),
              ),
            ),
          ),
        ),
        Image.asset("assets/PNG/age1-3.png", scale: 0.9,),
      ],
    );
  }

}
