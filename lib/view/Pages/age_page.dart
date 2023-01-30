import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../Widgets/polygon_Container.dart';
import 'gender_page.dart';
import 'story_category_page.dart';

class AgePage extends StatelessWidget {
  const AgePage({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    AgeSelect selectAge;

    return Scaffold(
      backgroundColor: AppColors.kScreenColor,
      body: SafeArea(
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
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
                    Image.asset("assets/PNG/age1-3.png", scale: 0.9,),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 60,
                      width: 110,
                      decoration: ShapeDecoration(
                        // color: Colors.red,
                          shape: polygonAgeContainer()),
                      child: const Center(
                        child: Text(
                          "3 - 5",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: "BalooBhai",
                              color: AppColors.txtColor1),
                        ),
                      ),
                    ),
                    Image.asset("assets/PNG/age3-5.png", scale: 0.9,),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 60,
                      width: 110,
                      decoration: ShapeDecoration(
                        // color: Colors.red,
                          shape: polygonAgeContainer()),
                      child: const Center(
                        child: Text(
                          "5 - 10",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: "BalooBhai",
                              color: AppColors.txtColor1),
                        ),
                      ),
                    ),
                    Image.asset("assets/PNG/age5-10.png", scale: 0.9,),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 60,
                      width: 110,
                      decoration: ShapeDecoration(
                        // color: Colors.red,
                          shape: polygonAgeContainer()),
                      child: const Center(
                        child: Text(
                          "10 +",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: "BalooBhai",
                              color: AppColors.txtColor1),
                        ),
                      ),
                    ),
                    Image.asset("assets/PNG/age10.png", scale: 0.9,),
                  ],
                ),
                const SizedBox(height: 35,),
                ElevatedButton(
                    onPressed: (){
                      // Get.to(const AgePage());
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StoryCategoryPage()));
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
      ),
    );
  }
}
