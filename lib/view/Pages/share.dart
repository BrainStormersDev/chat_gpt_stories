// import 'package:flutter/material.dart';
//
// import '../../utils/app_color.dart';
//
// class Share extends StatelessWidget {
//   const Share({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.kScreenColor,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         backgroundColor: AppColors.kScreenColor,
//         leading: IconButton(
//           onPressed: (){
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back, color: AppColors.txtColor1,), ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20.0,right: 20, top: 20, bottom: 10),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   // mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                         height: 27,
//                         child: Image.asset("assets/PNG/gridIcon.png")),
//                     SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
//                     const Text(
//                       "Story ",
//                       style: TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: "BalooBhai",
//                           color: AppColors.kBtnColor),
//                     ),
//                     const Text(
//                       "By GPT",
//                       style: TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: "BalooBhai",
//                           color: AppColors.txtColor1),
//                     ),
//                     const Spacer(),
//                     SizedBox(
//                         height: 30,
//                         child: Image.asset("assets/PNG/bellIcon.png")),
//                   ],
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.05,
//                 ),
//                 SizedBox(
//                   child: Image.asset("assets/PNG/img_3.png", fit: BoxFit.fitHeight,),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );;
//   }
// }
