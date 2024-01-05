import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  static const kSplashColor = Color(0xFFFEF0D6);
  static const kWhite = Colors.white;
  static const kGrey = Colors.grey;
  static const kBlack = Colors.black;
  static const kPrimary =Color(0xFFFFBA17);
  static const kRed =Colors.red;
  static const kScreenColor = Color(0xFFF5F5F5);
  static const kOrbit1 = Color(0xFF7511F4);
  static const kBtnColor = Color(0xFFFFBA17);
  static  Color kBtnShadowColor = const Color(0xFFFFBA17).withOpacity(0.5);
  static const kBtnTxtColor = Color(0xFF580600);
  static const kBoyBGColor = Color(0xFF4EA6FF);
  static const kGirlBGColor = Color(0xFFFF499E);
  static const txtColor1 = Color(0xFF021E40);
  static Color txtColor2 = Color(0xFF021E40).withOpacity(0.5);
  static Color textFieldColor = Color(0xFFE8ECF4);
  static Color emoji1Color = Color(0xFFE65460);
  static Color emoji2Color = Color(0xFFEB7E4F);
  static Color emoji3Color = Color(0xFFF3C700);
  static Color emoji4Color = Color(0xFF9AC765);
  static Color emoji5Color = Color(0xFF9AC765);
  static Color dropDownColor = Color(0xFF7F8F9);
  // static  LinearGradient kScreenColor = const LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xFFFEF0D6), Color(0xFFF5F5F5)]);

  // static ThemeData lightTheme = ThemeData(
  //   backgroundColor: kWhite,
  //   primaryColor: kWhite,
  //   accentColor: kWhite,
  //   scaffoldBackgroundColor: kWhite,
  //   appBarTheme: AppBarTheme(
  //     textTheme: TextTheme(
  //       headline6: TextStyle(
  //         color: kBlack,
  //         fontSize: 18.0,
  //         fontWeight: FontWeight.w800,
  //       ),
  //     ),
  //   ),
  // );
  //
  // static OutlineInputBorder outlineInputBorder(Color color) {
  //   return OutlineInputBorder(
  //     borderRadius: BorderRadius.all(Radius.circular(10)),
  //     borderSide: BorderSide(width: 1.5, color: color),
  //   );
  // }
  //
  // static TextStyle myTextStyle(double fontSize, FontWeight fontWeight) {
  //   return TextStyle(
  //     fontSize: fontSize,
  //     fontWeight: fontWeight,
  //   );
  // }
}

changeSystemUIOverlayColor(Color statusBarColor, Color navBarColor) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusBarColor, // Change status bar color
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: navBarColor, // Change navigation bar color
      systemNavigationBarIconBrightness: Brightness.dark
    ),
  );
}
