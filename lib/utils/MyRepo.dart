import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/selectAgeModel.dart';
import '../model/storyCatListModel.dart';

class MyRepo {
  static final assetsAudioPlayer = AssetsAudioPlayer();
  static List<String> ageList = ['1-3', '3-5', '5-10', '10+'];
  static List<String> gender = ['Boy', 'Girl'];
  static List<SelectAgeClass> selectAgeList = [
    SelectAgeClass(age: '1-3', assetImage: kOneToThreeLogo),
    SelectAgeClass(age: '3-5', assetImage: kThreeToFiveLogo),
    SelectAgeClass(age: '5-10', assetImage: kFiveToTenLogo),
    SelectAgeClass(age: '10+', assetImage: kTenPlusLogo)
  ];
  static List emojiList = [
    "assets/PNG/emoji_rate_1.png",
    "assets/PNG/emoji_rate_2.png",
    "assets/PNG/emoji_rate_3.png",
    "assets/PNG/emoji_rate_4.png",
    "assets/PNG/emoji_rate_5.png"
  ];
  static const List<Color> emojiListColor = [
    Color(0xFFE65460),
    Color(0xFFEB7E4F),
    Color(0xFFF3C700),
    Color(0xFF9AC765),
    Color(0xFF9AC765)
  ];
  static RxString deviceToken = ''.obs;
  static RxInt count = 0.obs;
  static Gender selectedGender = Gender.notSelect;
  static RxBool musicMuted = false.obs;
  // static AgeSelect selectAge=AgeSelect.notSelect;

  static RxString kApiToken =
      "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".obs;

  static DataList currentStory = DataList();
  static String storyCat="";
  static String rating="1";
  static String bearerToken = "";
  static String userID = "";
  static bool islogInHomeScreen=false;
  static bool islogIn=false;
}

const String kAge = "AgeParam";
const String kGender = "kGender";
const String kMute = "kMute";
const String kTokenStorage = "token";
 String userEmail = "";
bool isSignedInUser=false;

const String kBaseUrl = "http://story-telling.eduverse.uk/api/v1/";
const String kLogoAsset = "assets/PNG/loin.png";
const String kOneToThreeLogo = "assets/PNG/age1-3.png";
const String kThreeToFiveLogo = "assets/PNG/age3-5.png";
const String kFiveToTenLogo = "assets/PNG/age5-10.png";
const String kTenPlusLogo = "assets/PNG/age10.png";
const String kWelcomeSound = "assets/audio/welcome_sound.mp3";
const String kDemoImage =
    "https://pi.tedcdn.com/r/talkstar-assets.s3.amazonaws.com/production/playlists/playlist_62/how_to_tell_a_story_update.jpg?u%5Br%5D=2&u%5Bs%5D=0.5&u%5Ba%5D=0.8&u%5Bt%5D=0.03&quality=82&w=600c=1050%2C550&w=1050";

enum Gender { notSelect, Boy, Girl }

enum AgeSelect {
  notSelect,
  two,
  four,
  seven,
  thirteen,
}
Future<void> handleSignIn() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  try {
    // final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    // final GoogleSignInAuthentication googleSignInAuthentication = await googleUser!.authentication;
    //
    // _googleSignIn.currentUser!.authentication;
    // _googleSignIn.isSignedIn();

   bool isSignedIn=  await  _googleSignIn.isSignedIn();
   if(isSignedIn){
     isSignedInUser=true;
     print("===== fetch data against email ====");
   }
   else{
     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
     userEmail=  googleUser!.email.toString();
   }
    print("========== google email  ${await  _googleSignIn.isSignedIn()}=== ");
    // final OAuthCredential credential = GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken,);
    // TODO: Handle signed in user
  } catch (error) {
    print(error);
  }
}