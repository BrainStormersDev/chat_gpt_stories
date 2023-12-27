import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../utils/MyRepo.dart';
import '../../utils/app_color.dart';
import '../../utils/mySnackBar.dart';
import 'age_page.dart';



class GenderPage extends StatefulWidget {
  @override
  State<GenderPage> createState() => _GenderPageState();
}


class _GenderPageState extends State<GenderPage> {

  // const GenderPage({Key? key}) : super(key: key);
  //
  // RxBool isBoy = false.obs;
  // RxBool isGirl = false.obs;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.kScreenColor,
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.06,
                // ),
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
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                  child: Text(
                    "Tell us about yourself so we can tell a story specially written for you.",
                    style: TextStyle(color: AppColors.txtColor2, fontSize: 21),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    // SizedBox(width: 20,),
                    Text(
                      "I am a",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "BalooBhai",
                          color: AppColors.txtColor1),
                    ),
                  ],
                ),
                const SizedBox(height: 35,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border:MyRepo.selectedGender==Gender.Boy ? Border.all(color:AppColors.kPrimary,width: 5 ):null,
                        color:MyRepo.selectedGender==Gender.Boy ? AppColors.kPrimary:null

                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: (){
                              // isBoy.value == true;
                              // isGirl.value == false;
                              // print("========isBoy.value====${isBoy.value}");
                              setState(() {
                                MyRepo.selectedGender=Gender.Boy;

                              });
                              // Future.delayed(const Duration(milliseconds: 100), () {
                              //   Navigator.push(context, MaterialPageRoute(builder: (context) => const AgePage()));
                              // });



                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  color:MyRepo.selectedGender==Gender.Boy ? AppColors.kBoyBGColor : Colors.transparent,
                                  border: Border.all(
                                      color: AppColors.kBoyBGColor, width: 2)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/PNG/boy.png"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Boy",
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: "BalooBhai",
                                fontWeight: FontWeight.bold,
                                // color: selectedGender==Gender.boy ? AppColors.kBoyBGColor : Colors.transparent,
                                foreground: Paint()
                                  ..style =MyRepo. selectedGender==Gender.Boy ? PaintingStyle.fill : PaintingStyle.stroke
                                  ..color =MyRepo.selectedGender==Gender.Boy ?AppColors.kWhite: AppColors.kBoyBGColor),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:MyRepo.selectedGender==Gender.Girl ? Border.all(color:AppColors.kPrimary,width: 5 ):null,
                          color:MyRepo.selectedGender==Gender.Girl ? AppColors.kPrimary:null

                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: (){
                              // isGirl.value == true;
                              // isBoy.value == false;
                              // print("========isGirl.value====${isGirl.value}");
                              setState(() {
                                MyRepo.selectedGender=Gender.Girl;

                              });
                              // Future.delayed(const Duration(milliseconds: 100), () {
                              //   Navigator.push(context, MaterialPageRoute(builder: (context) => const AgePage()));
                              // });
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  color: MyRepo. selectedGender==Gender.Girl? AppColors.kGirlBGColor : Colors.transparent,
                                  border: Border.all(
                                      color: AppColors.kGirlBGColor, width: 2)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/PNG/girl.png"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Girl",
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: "BalooBhai",
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..style = MyRepo.selectedGender==Gender.Girl ? PaintingStyle.fill : PaintingStyle.stroke
                                  ..color =MyRepo.selectedGender==Gender.Girl ?AppColors.kWhite: AppColors.kGirlBGColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35,),
                ElevatedButton(
                    onPressed: (){
                      // Get.to(const AgePage());
                      print("=======select :${MyRepo.selectedGender.name} ====");
                      if(MyRepo.selectedGender==Gender.notSelect){
                        MySnackBar.snackBarYellow(
                            title:"Alert", message:"Please select Gender");
                      }
                      else{
                        print("=======select :${MyRepo.selectedGender.name} ====");
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  AgePage()));
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
        ),
      ));

  }
}
