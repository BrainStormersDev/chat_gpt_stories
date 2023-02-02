import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/chat_image_controller.dart';
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
                      MyRep.selectAge=AgeSelect.oneToThree;

                    });
                    nextPage();



                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border:MyRep.selectAge==AgeSelect.oneToThree? Border.all(color:AppColors.kPrimary,width: 5 ):null,
                        color:MyRep.selectAge==AgeSelect.oneToThree ? AppColors.kPrimary:null,
                        borderRadius: BorderRadius.circular(10)

                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              MyRep.selectAge=AgeSelect.oneToThree;

                            });
                            nextPage();


                          },
                          child: Container(
                            height: 60,
                            width: 110,
                            decoration: ShapeDecoration(
                              color: MyRep.selectAge==AgeSelect.oneToThree ?AppColors.kPrimary:null,
                                shape: polygonAgeContainer(bordColor:MyRep.selectAge==AgeSelect.oneToThree?AppColors.kWhite:AppColors.txtColor1)

                            ),
                            child:  Center(
                              child: Text(
                                "1 - 3",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "BalooBhai",
                                    color: MyRep.selectAge==AgeSelect.oneToThree?AppColors.kWhite:AppColors.txtColor1),
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
                      MyRep.selectAge=AgeSelect.threeToFive;

                    });
                    nextPage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border:MyRep.selectAge==AgeSelect.threeToFive? Border.all(color:AppColors.kPrimary,width: 5 ):null,
                        color:MyRep.selectAge==AgeSelect.threeToFive ? AppColors.kPrimary:null,
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
                              color:MyRep. selectAge==AgeSelect.threeToFive ?AppColors.kPrimary:null,
                              shape: polygonAgeContainer(bordColor:MyRep.selectAge==AgeSelect.threeToFive?AppColors.kWhite:AppColors.txtColor1)),
                          child:  Center(
                            child: Text(
                              "3 - 5",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "BalooBhai",
                                  color:MyRep. selectAge==AgeSelect.threeToFive?AppColors.kWhite:AppColors.txtColor1),
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
                      MyRep. selectAge=AgeSelect.fiveToTen;

                    });
                    nextPage();

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border:MyRep.selectAge==AgeSelect.fiveToTen? Border.all(color:AppColors.kPrimary,width: 5 ):null,
                        color:MyRep.selectAge==AgeSelect.fiveToTen ? AppColors.kPrimary:null,
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
                            color: MyRep.selectAge==AgeSelect.fiveToTen ?AppColors.kPrimary:null,
                              shape: polygonAgeContainer(bordColor:MyRep.selectAge==AgeSelect.fiveToTen?AppColors.kWhite:AppColors.txtColor1)),
                          child:  Center(
                            child: Text(
                              "5 - 10",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "BalooBhai",
                                  color: MyRep.selectAge==AgeSelect.fiveToTen?AppColors.kWhite:AppColors.txtColor1),
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
                      MyRep.selectAge=AgeSelect.tenPlus;

                    });
                    nextPage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border:MyRep.selectAge==AgeSelect.tenPlus? Border.all(color:AppColors.kPrimary,width: 5 ):null,
                        color:MyRep.selectAge==AgeSelect.tenPlus ? AppColors.kPrimary:null,
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
                              color:MyRep. selectAge==AgeSelect.tenPlus ?AppColors.kPrimary:null,
                              shape: polygonAgeContainer(bordColor:MyRep.selectAge==AgeSelect.tenPlus?AppColors.kWhite:AppColors.txtColor1)),
                          child:  Center(
                            child: Text(
                              "10 +",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "BalooBhai",
                                  color: MyRep.selectAge==AgeSelect.tenPlus?AppColors.kWhite:AppColors.txtColor1),
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
                      if(MyRep.selectAge==AgeSelect.notSelect){
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
