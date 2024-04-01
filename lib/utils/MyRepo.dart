import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

import '../model/selectAgeModel.dart';
import '../model/storyCatListModel.dart';
import 'apiCall.dart';
Logger logger=Logger();
class MyRepo {

  static final assetsAudioPlayer = AssetsAudioPlayer();
  static List<String> ageList = ['1-3', '3-5', '5-10', '10+'];
  static List<String> gender = ['Boy', 'Girl'];
  static List<SelectAgeClass> selectGirlAgeList = [
    SelectAgeClass(age: '1-3', assetImage: kOneToThreeLogoGirl),
    SelectAgeClass(age: '3-5', assetImage: kThreeToFiveLogoGirl),
    SelectAgeClass(age: '5-10', assetImage: kFiveToTenLogoGirl),
    SelectAgeClass(age: '10+', assetImage: kTenPlusLogoGirl)
  ];
  static List<SelectAgeClass> selectBoyAgeList = [
    SelectAgeClass(age: '1-3', assetImage: kOneToThreeLogoBoy),
    SelectAgeClass(age: '3-5', assetImage: kThreeToFiveLogoBoy),
    SelectAgeClass(age: '5-10', assetImage: kFiveToTenLogoBoy),
    SelectAgeClass(age: '10+', assetImage: kTenPlusLogoBoy)
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
  static RxBool isStoryReading = false.obs;
  // static AgeSelect selectAge=AgeSelect.notSelect;

  static RxString kApiToken = "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".obs;

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

const String kBaseUrl = "https://gptstory.thebrainstormers.org/";
const String v1 = "https://gptstory.thebrainstormers.org/api/v1/";
const String audioLink = "${kBaseUrl}/public/s_1.mp3";
const String kLogoAsset = "assets/PNG/loin.png";
const String kOneToThreeLogoBoy = "assets/PNG/boyBaby.png";
const String kThreeToFiveLogoBoy = "assets/PNG/boyKid.png";
const String kFiveToTenLogoBoy = "assets/PNG/boyChild.png";
const String kTenPlusLogoBoy = "assets/PNG/boyTeen.png";
const String kOneToThreeLogoGirl = "assets/PNG/girlBaby.png";
const String kThreeToFiveLogoGirl = "assets/PNG/girlKid.png";
const String kFiveToTenLogoGirl = "assets/PNG/girlChild.png";
const String kTenPlusLogoGirl = "assets/PNG/girlTeen.png";
const String kWelcomeSound = "assets/audio/welcome_sound.mp3";
const String kDemoImage = "https://pi.tedcdn.com/r/talkstar-assets.s3.amazonaws.com/production/playlists/playlist_62/how_to_tell_a_story_update.jpg?u%5Br%5D=2&u%5Bs%5D=0.5&u%5Ba%5D=0.8&u%5Bt%5D=0.03&quality=82&w=600c=1050%2C550&w=1050";

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
   bool isSignedIn=  await  _googleSignIn.isSignedIn();
   if(isSignedIn){
     isSignedInUser=true;
   }
   else{
     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
     userEmail=  googleUser!.email.toString();
   }
    // TODO: Handle signed in user
  } catch (error) {
    print(error);
  }
}
Future<void> signInWithGoogle(context) async {
  var auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  try {
  final GoogleSignInAccount? googleSignOutAccount;
  googleSignOutAccount= await googleSignIn.signOut();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
  final OAuthCredential credential = GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken,);
  final UserCredential userCredential = await auth.signInWithCredential(credential);
  final User? user = userCredential.user;
  var body={
    "name":"${user!.displayName}",
    "email":"${user.email}",
    "auth_type":"google",
  };
  ApisCall.apiCall("${kBaseUrl}api/v1/social-auth", "post", body).then((value){
    if(value["isData"]==true){
      GetStorage().write(
          "userName",
          jsonDecode(value["response"])["data"]
          ["email"]);
      Get.close(1);
      MyRepo.islogIn=true;
    }
  });

  log("User signed in with Google: $user'");
    }
  catch (e){
      print("=====catch == error $e");
  }
}