

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../model/selectAgeModel.dart';


class MyRepo{

 static final   assetsAudioPlayer = AssetsAudioPlayer();
 static  List<String> ageList = ['1-3', '3-5', '5-10', '10+'];


 static List<SelectAgeClass> selectAgeList=[SelectAgeClass( age: '1-3', assetImage: kOneToThreeLogo),SelectAgeClass( age: '3-5', assetImage: kThreeToFiveLogo),SelectAgeClass( age: '5-10', assetImage: kFiveToTenLogo),SelectAgeClass( age: '10+', assetImage: kTenPlusLogo)];


  static RxString deviceToken=''.obs;
  static RxInt count=0.obs;
 static Gender selectedGender =Gender.notSelect;
 // static AgeSelect selectAge=AgeSelect.notSelect;

  static RxString kApiToken="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".obs;


}

const String kAge="AgeParam";
const String kGender="kGender";
const String kTokenStorage="token";



const String kBaseUrl="http://story-telling.eduverse.uk/api/v1/";
const String kLogoAsset="assets/PNG/loin.png";
const String kOneToThreeLogo="assets/PNG/age1-3.png";
const String kThreeToFiveLogo="assets/PNG/age3-5.png";
const String kFiveToTenLogo="assets/PNG/age5-10.png";
const String kTenPlusLogo="assets/PNG/age10.png";
const String kWelcomeSound="assets/audio/welcome_sound.mp3";
const String kDemoImage="https://pi.tedcdn.com/r/talkstar-assets.s3.amazonaws.com/production/playlists/playlist_62/how_to_tell_a_story_update.jpg?u%5Br%5D=2&u%5Bs%5D=0.5&u%5Ba%5D=0.8&u%5Bt%5D=0.03&quality=82&w=600c=1050%2C550&w=1050";





enum Gender {
  notSelect,
  Boy,
  Girl
}
enum AgeSelect {
  notSelect,
  two,
  four,
  seven,
  thirteen,
}