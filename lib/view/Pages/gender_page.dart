import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../utils/app_color.dart';
import 'age_page.dart';

class GenderPage extends StatefulWidget {
  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  // const GenderPage({Key? key}) : super(key: key);

  RxBool isBoy = false.obs;
  RxBool isGirl = false.obs;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.kScreenColor,
      body: Obx(() {
        return SafeArea(
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
                    height: 10,
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
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: (){
                              isBoy.value == true;
                              isGirl.value == false;
                              print("========isBoy.value====${isBoy.value}");
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  color: isBoy.value == true ? AppColors.kBoyBGColor : Colors.transparent,
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
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..color = AppColors.kBoyBGColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: (){
                              isGirl.value == true;
                              isBoy.value == false;
                              print("========isGirl.value====${isGirl.value}");
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                color: isGirl.value == true ? AppColors.kGirlBGColor : Colors.transparent,
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
                                  ..style = PaintingStyle.stroke
                                  ..color = AppColors.kGirlBGColor),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 35,),
                  ElevatedButton(
                      onPressed: (){
                        // Get.to(const AgePage());
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AgePage()));
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
        );
      })
    );
  }
}
