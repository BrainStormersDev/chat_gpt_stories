import 'package:assets_audio_player/assets_audio_player.dart';

import '../utils/MyRepo.dart';

class BackgroundMusicManager {
  static final BackgroundMusicManager _instance = BackgroundMusicManager._internal();
  factory BackgroundMusicManager() => _instance;

  BackgroundMusicManager._internal() {
    _init();
  }

  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  void _init() {
    playMusic();

  }

  void playMusic() async {
    await _assetsAudioPlayer.open(
        Playlist(audios: [
          Audio.network(
              "${audioLink}"),
        ]),
        loopMode: LoopMode.playlist);
  }

  void pauseMusic() {
    // Pause the currently playing audio
    _assetsAudioPlayer.pause();
  }

  void resumeMusic() {
    // Resume the paused audio
    _assetsAudioPlayer.play();
  }
}
