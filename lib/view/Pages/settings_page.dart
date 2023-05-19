import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chat_gpt_stories/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/MyRepo.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // bool isMuted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kScreenColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.kScreenColor,
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: AppColors.txtColor1,), ),
      ),
      body: Center(
        child: Column(
          children: [
            IconButton(
                onPressed: () async {
                  setState(() {
                    MyRepo.musicMuted.value = !MyRepo.musicMuted.value;
                  });
                  MyRepo.musicMuted.value == true ?
                  await MyRepo.assetsAudioPlayer.pause() :
                  await MyRepo.assetsAudioPlayer.open(
                        Playlist(
                            audios: [
                              Audio.network("http://story-telling.eduverse.uk/public/s_1.mp3"),
                            ]),
                        loopMode: LoopMode.playlist
                    );
                },
                icon: Icon(MyRepo.musicMuted.value == true ? Icons.volume_off : Icons.volume_up, color: AppColors.kBtnColor, size: 30,)),
            Row(
              children: [
                Text(
                    "Age :",
                  style: GoogleFonts.balooBhai2().copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}
