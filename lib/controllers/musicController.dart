import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/widgets.dart';

import '../utils/MyRepo.dart';

class BackgroundMusicManager with WidgetsBindingObserver {
  static final BackgroundMusicManager _instance =
      BackgroundMusicManager._internal();

  factory BackgroundMusicManager() => _instance;

  BackgroundMusicManager._internal() {
    _init();
  }

  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  void _init() {
    playMusic();
    WidgetsBinding.instance.addObserver(this);
  }

  void playMusic() async {
    try {
      await _assetsAudioPlayer.open(
          Playlist(audios: [
            Audio("assets/PNG/s_1.mp3"),
            // Audio.network(
            //     "${audioLink}"),
          ]),
          loopMode: LoopMode.playlist,
          autoStart: true);
    } catch (e) {
      logger.e("error is : $e");
    }
  }

  void pauseMusic() {
    // Pause the currently playing audio
    _assetsAudioPlayer.pause();
  }

  void resumeMusic() {
    // Resume the paused audio
    _assetsAudioPlayer.play();
  }

  void toggleMute() {
    if (MyRepo.musicMuted.value) {
      pauseMusic();
    } else {
      resumeMusic();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        if (!MyRepo.musicMuted.value) {
          pauseMusic();
        }

        break;
      case AppLifecycleState.resumed:
        if (!MyRepo.musicMuted.value && !MyRepo.isStoryReading.value) {
          print("music resumed");
          resumeMusic();
        }
        break;
      default:
        break;
    }
  }
}
