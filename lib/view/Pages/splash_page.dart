import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gpt_chat_stories/view/Pages/versionUpdatePage.dart';
import '../../controllers/musicController.dart';
import '../../controllers/versions.dart';
import '../../utils/dynamic_link_provider.dart';
import '../../view/Pages/story_category_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';
import '../../utils/MyRepo.dart';
import '../../utils/app_color.dart';
import '../../utils/app_size.dart';
import '../../utils/mySnackBar.dart';
import 'gender_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin{
  late Connectivity _connectivity;
  late StreamSubscription subscription;
  bool _isNetworkConnected = true;
  late AnimationController _animationController;
  double? progressValue;



  @override
  void initState() {
    // TODO: implement initState
    getInterNetConnections();
    versionCheck();
    _updateProgress();
    super.initState();
    var mute=GetStorage().read(kMute);
    if(mute!=null){
      MyRepo.musicMuted.value=mute;
    }

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]
    );
    DynamicLinksProvider().initDynamicLink();
    changeSystemUIOverlayColor(AppColors.kSplashColor, AppColors.kWhite);
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
                   Text("By GPT", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "BalooBhai", color: AppColors.txtColor1),),
                 ],
               ),
               const SizedBox(height: 10,),
               DefaultTextStyle(
                 style: const TextStyle(
                     fontSize: 20.0,
                     fontFamily: 'Bobbers',
                     color:  AppColors.txtColor1
                 ),
                 child: AnimatedTextKit(

                   animatedTexts: [

                     TyperAnimatedText("Welcome to new platform of \n Story Telling. Let’s Begin",
                       // TyperAnimatedText(controllerText.messages[0].text,
                       textStyle: TextStyle(color: AppColors.txtColor1, fontSize: 15),

                       speed: const Duration(milliseconds: 70),

                     ),
                   ],
                   onTap: () {
                   },
                   stopPauseOnTap: true,
                   totalRepeatCount: 1,

                 ),
               ),
               // const Text("Welcome to new platform of \n Story Telling. Let’s Begin",
               //   style: TextStyle(color: AppColors.txtColor1, fontSize: 15), textAlign: TextAlign.center,),
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
              child: Column(
                children: [
                  if (_isNetworkConnected)
                    Container(
                        margin:
                        EdgeInsets.only(bottom: AppSizes.appVerticalMd * 0.2),
                        child: Column(
                          children: [
                            const Text(
                              "No Internet Connection",
                              style: TextStyle(
                                  color: AppColors.kRed, fontWeight: FontWeight.w700),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SpinKitWave(
                                  color:AppColors.kPrimary,
                                  size: 20.0,
                                ),
                                SizedBox(width: 10,),
                                Text("Connecting to internet...",style: TextStyle(
                                    color: AppColors.kPrimary, fontWeight: FontWeight.w700),)
                              ],
                            )
                          ],
                        )),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                        onPressed:
                            () async {
                        ///Start
                        if(!_isNetworkConnected){

                          if(versionMismatch){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>VersionUpdatePage()));
                          }
else

                          if(GetStorage().hasData(kGender) ){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                StoryCategoryPage( )));
                          }
                          else{
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                GenderPage( )));
                          }
                          if(!MyRepo.musicMuted.value)
                            BackgroundMusicManager().playMusic();
                      }

                        else{
                          MySnackBar.snackBarRed(
                              title: "Alert",
                              message: "Not internet connection found");
                        }
                        ///End
                      },
                      style: ButtonStyle(
                        shadowColor:  MaterialStatePropertyAll(AppColors.kBtnShadowColor),
                        backgroundColor:  MaterialStatePropertyAll(!_isNetworkConnected?AppColors.kBtnColor:AppColors.kGrey),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
                      ),
                      child: const SizedBox(
                          height: 50,
                          // width: MediaQuery.of(context).size.width/2,
                          child: Center(
                              child: Text("Start",
                                style: TextStyle(color: AppColors.kBtnTxtColor, fontWeight: FontWeight.bold, fontSize: 18))))),
                ],
              ),
          ),

        ],
      ),

    );
  }


  Future<void> getInterNetConnections() async {
    _connectivity = Connectivity();
    ConnectivityResult result = ConnectivityResult.none;
    result = await _connectivity.checkConnectivity();

    if(result != ConnectivityResult.none){
      setState(() {
        _isNetworkConnected = false;
      });
    }
    subscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        setState(() {
          print("----------------------Internet Connected-----------------");
          _isNetworkConnected = false;
        });
      } else {
        setState(() {
          print("----------------------Internet Not Connected-----------------");
          _isNetworkConnected = true;
        });
      }
    });
  }


  Future<void> _updateProgress() async {
    _animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _animationController.repeat(reverse: true);

  }




}

