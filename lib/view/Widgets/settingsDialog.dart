import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/MyRepo.dart';
import '../../utils/app_color.dart';

void showCustomSettingDialog(BuildContext dialogContext, ) {
  RxString selectedAge = '${GetStorage().read(kAge)}'.obs;
  RxString selectedGender = "${GetStorage().read(kGender)}".obs;
  print("=======gender==${GetStorage().read(kGender)}====");

  showGeneralDialog(
    context: dialogContext,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder: (BuildContext context, __, ___) {
      dialogContext = context;
      return Material(
          color: Colors.transparent,
          child: Obx(
                () => Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                // height: 240,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Text(
                              "Settings",
                              style: GoogleFonts.balooBhai2().copyWith(
                                  fontSize: 20,
                                  color: AppColors.txtColor1,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(dialogContext);
                              },
                              child: const Icon(
                                FontAwesomeIcons.circleXmark,
                                size: 30,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Text(
                              "Age",
                              style: GoogleFonts.balooBhai2().copyWith(
                                  fontSize: 20,
                                  color: AppColors.txtColor1,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.kPrimary)),
                          child: DropdownButton(
                            underline: Container(),
                            isExpanded: false,
                            hint: const Text(
                                'Please choose a location'), // Not necessary for Option 1
                            value: selectedAge.value,
                            onChanged: (newValue) {
                              selectedAge.value = newValue!;
                              // GetStorage().write(kAge, selectedAge.value );
                            },
                            items: MyRepo.ageList.map((location) {
                              return DropdownMenuItem(
                                value: location,
                                child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(location,
                                        style: const TextStyle(
                                            color: AppColors.kPrimary))),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Text(
                              "Gender",
                              style: GoogleFonts.balooBhai2().copyWith(
                                  fontSize: 20,
                                  color: AppColors.txtColor1,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.kPrimary)),
                          child: DropdownButton(
                            underline: Container(),
                            isExpanded: false,
                            hint: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  selectedGender.value,
                                  style: const TextStyle(
                                      color: AppColors.kPrimary)
                              ),
                            ),
                            // Not necessary for Option 1
                            // value: selectedGender.value,
                            onChanged: (newValue) {
                              selectedGender.value = newValue!;
                              // GetStorage().write(kAge, selectedAge.value );
                            },
                            items: MyRepo.gender.map((location) {
                              return DropdownMenuItem(
                                value: location,
                                child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(location,
                                        style: const TextStyle(
                                            color: AppColors.kPrimary))),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                              "Music",
                              style: GoogleFonts.balooBhai2().copyWith(
                                  fontSize: 20,
                                  color: AppColors.txtColor1,
                                  fontWeight: FontWeight.bold),
                            )),
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              // setState(() {
                              MyRepo.musicMuted.value =
                              !MyRepo.musicMuted.value;
                              print(MyRepo.musicMuted.value);

                              // });
                              MyRepo.musicMuted.value
                                  ? await MyRepo.assetsAudioPlayer.pause()
                                  : await MyRepo.assetsAudioPlayer.open(
                                  // Playlist(audios: [
                                  //   Audio.network(
                                  //       "http://story-telling.eduverse.uk/public/s_1.mp3"),
                                  // ]),
                                  Audio("assets/audio/s_1.mp3"),
                                  loopMode: LoopMode.playlist
                              );
                            },
                            icon: Icon(
                              MyRepo.musicMuted.value == true
                                  ? Icons.volume_off
                                  : Icons.volume_up,
                              color: AppColors.kBtnColor,
                              size: 30,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          // GetStorage().erase();

                          GetStorage().write(kAge, selectedAge.value);
                          GetStorage().write(kGender, selectedGender.value);
                          GetStorage().write(kMute, MyRepo.musicMuted.value);
                          print("========selectedAge.value  =${GetStorage().read(kAge)}");
                          print("========selectedGender.value  =${GetStorage().read(kGender)}");
                          print("========repo muted value  =${GetStorage().read(kMute)}");
                          Navigator.pop(dialogContext);
                        },
                        style: ButtonStyle(
                            shadowColor: MaterialStatePropertyAll(
                                AppColors.kBtnShadowColor),
                            backgroundColor: const MaterialStatePropertyAll(
                                AppColors.kBtnColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(15)))),
                        child: const SizedBox(
                            height: 50,
                            // width: MediaQuery.of(context).size.width/2,
                            child: Center(
                                child: Text("Done",
                                    style: TextStyle(
                                        color: AppColors.kBtnTxtColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18))))),
                  ],
                ),
              ),
            ),
          ));
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}