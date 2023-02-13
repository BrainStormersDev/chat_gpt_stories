import 'package:flutter/material.dart';

class AppSizes {
  late MediaQueryData _mediaQueryData;

  static double screenWidth=0;
  static double screenHeight=0;
  static double blockSizeHorizontal=0.0;
  static double blockSizeVertical=0;

  //* SafeBlocks for dealing with notches, navigation bar, status bars etc
  static double _safeAreaHorizontal=0;
  static double _safeAreaVertical=0;

  //* safeBlockHorizontal Can also be used to scale texts
  static double safeBlockHorizontal=0.0;
  static double safeBlockVertical=0;

  //* For main Container Padding
  static double appMarginVertical = blockSizeVertical * 5;
  static double appMarginHorizontal = blockSizeHorizontal * 5;

  //* For Horizontal Padding and Sizes
  static double appHorizontalXs = blockSizeHorizontal;
  static double appHorizontalSm = blockSizeHorizontal * 3;
  static double appHorizontalMd = blockSizeHorizontal * 6;
  static double appHorizontalLg = blockSizeHorizontal * 10;
  static double appHorizontalXL = blockSizeHorizontal * 15;
  static double appHorizontalXXL = blockSizeHorizontal * 20;

  //* For Vertical Padding and Sizes
  static double appVerticalXs = blockSizeVertical;
  static double appVerticalSm = blockSizeVertical * 2;
  static double appVerticalMd = blockSizeVertical * 5;
  static double appVerticalLg = blockSizeVertical * 8;
  static double appVerticalXL = blockSizeVertical * 11;
  static double appVerticalXXL = blockSizeVertical * 16;

  //* Divides entire screen into 100 blocks for a consistent size reference
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}