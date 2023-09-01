import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morphable_shape/morphable_shape.dart';

import '../../utils/app_color.dart';


PolygonShapeBorder polygonAgeContainer ({Color bordColor =AppColors.txtColor1}) {
  return PolygonShapeBorder(
      sides:6,
      border: DynamicBorderSide(
        style: BorderStyle.solid,
        width: 1,
        color:bordColor,
        // gradient: LinearGradient(colors:[Colors.red, Colors.blue]),
        begin: 0.toPercentLength,
        end: 100.toPercentLength,
        // offset: 0.toPercentLength,
        strokeJoin: StrokeJoin.miter,
        strokeCap: StrokeCap.round,
      ),
      cornerRadius: 10.toPercentLength,
      cornerStyle: CornerStyle.rounded
  );
}