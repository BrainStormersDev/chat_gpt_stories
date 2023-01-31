import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_color.dart';
import 'gender_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kSplashColor,
      body: Stack(
        children: [
          Positioned(
           top: 90,
           left: 30,
           right: 30,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: const [
                   Text("Story ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "BalooBhai", color: AppColors.kBtnColor),),
                   Text("By Chat GPT", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "BalooBhai", color: AppColors.txtColor1),),
                 ],
               ),
               const SizedBox(height: 10,),
               const Text("Welcome to new platform of \nStory Telling. Let’s Begin",
                 style: TextStyle(color: AppColors.txtColor1, fontSize: 15), textAlign: TextAlign.center,),
             ],
           ),),
          Positioned(
            bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height/2.3,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(150), topRight: Radius.circular(150))
                ),
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.63,
            // bottom: MediaQuery.of(context).size.height * 0.63,
            // left: 0,
            // right: 0,
            child: SizedBox(
                // height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/PNG/orbit.png")),
          ),
          Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              // height: MediaQuery.of(context).size.height/1.5,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/PNG/loin.png", scale: 1.2,)),
          ),
          ///Button
          Positioned(
            left: 40,
            right: 40,
            bottom: 40,
              child: ElevatedButton(
                  onPressed: (){


                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => GenderPage()), (route) => false);
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
                          child: Text("Start",
                            style: TextStyle(color: AppColors.kBtnTxtColor, fontWeight: FontWeight.bold, fontSize: 18))))),
          ),

        ],
      ),

    );
  }
}



// SizedBox(
// height: MediaQuery.of(context).size.height* 0.65,
// width: MediaQuery.of(context).size.width,
// child: Image.asset("assets/PNG/splash_vector.png"),
// )
