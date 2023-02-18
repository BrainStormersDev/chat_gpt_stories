// import 'package:flutter/material.dart';
// import 'package:local_db/utils/app_color.dart';
//
// class CustomButton extends StatelessWidget {
//   var height;
//   var width;
//   var color;
//   var text;
//   var onTap;
//   var shape;
//   var radius;
//   var textSize;
//
//    CustomButton({this.height, this.color, this.onTap, this.shape, this.text, this.width, this.radius, this.textSize});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       height: height,
//       width: width,
//       color: color,
//       child: ElevatedButton(
//           onPressed: onTap,
//           style: ButtonStyle(
//               shadowColor:  MaterialStatePropertyAll(color),
//               backgroundColor:  MaterialStatePropertyAll(color),
//               shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)))
//           ),
//           child: SizedBox(
//               height: height,
//               width: width,
//               child: Center(
//                   child: Text(text.toString(),
//                       style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: textSize))))),
//     );
//   }
// }
