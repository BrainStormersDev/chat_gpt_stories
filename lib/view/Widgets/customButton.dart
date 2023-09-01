import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class CustomButton extends StatelessWidget {
  var height;
  var width;
  var color;
  var txtcolor;
  var text;
  var onTap;
  var shape;
  var radius;
  var bordercolor;
  var textSize;

   CustomButton({this.height, this.color, this.txtcolor, this.onTap, this.shape, this.bordercolor, this.text, this.width, this.radius=5.0, this.textSize});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap:onTap ,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: bordercolor?? AppColors.kBtnColor),
          borderRadius: BorderRadius.circular(radius)
        ),
        child: Padding(
          padding:const EdgeInsets.all(8),
            child: Center(
              child: Text(text.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: txtcolor, fontWeight: FontWeight.bold, fontSize: textSize,fontFamily: "BalooBhai",)),
            )),
      ),
    );
  }
}
