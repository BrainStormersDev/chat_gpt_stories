// import 'package:get_storage/get_storage.dart';
// import '../../controllers/CreateStoryController.dart';
// import '../../utils/my_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:get/get.dart';
//
// import '../../common/headers.dart';
// import '../../utils/MyRepo.dart';
// import '../../utils/app_color.dart';
// import '../Widgets/constWidgets.dart';
//
// ///final
// FlutterTts tts = FlutterTts();
//
// class CreateNewStory extends StatelessWidget {
//    CreateNewStory({Key? key}) : super(key: key);
//   CreateStoryController controller =Get.put(CreateStoryController());
//   @override
//   Widget build(BuildContext context) {
//     logger.i(GetStorage().read("bearerToken"));
//
//     return Scaffold(
//       backgroundColor: AppColors.kScreenColor,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         title: storyByGptWidget(context),
//         centerTitle: true,
//         backgroundColor: AppColors.kScreenColor,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: InkWell(
//             onTap: (){
//               tts.stop();
//               Get.back();
//             },
//             child: const Icon(
//               Icons.arrow_back,
//               color: AppColors.txtColor1,
//             ),
//           ),
//         ),
//       ),
//       body:
//           Obx(()=>
//              Padding(
//               padding:
//               const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const  Center(
//                     child:  Text(
//                       "Create Your Own Story",
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: "BalooBhai",
//                           color: AppColors.txtColor1),
//                     ),
//                   ),
//                   Expanded(
//                     child: controller.allStoryData.isEmpty
//                         ?
//                     const Center(child: Text("No Story Created Yet",    style: TextStyle(
//                         fontFamily: "BalooBhai",
//                         color: AppColors.kGrey),),)
//                         :
//                     ListView.builder(
//                       reverse: true,
//                       itemCount: controller.allStoryData.length ?? 0,
//                       itemBuilder: (BuildContext context, int index) {
//                         final textData = controller.allStoryData[index];
//                         final title = controller.storyTitle[index];
//                         // logger.e(title);
//                         return
//                           textData.id==null
//                             ?
//                           MyTextCard(title: title)
//                             :
//                           TextCard(textData: textData);
//                       },
//                     ),
//                   ),
//                   controller.state.value == ApiState.loading
//                       ?
//                   Center(child: myIndicator())
//                   :
//                   controller.state.value == ApiState.error
//                   ?
//                   Container(child: Text('Something went wrong.Try again', style: TextStyle(
//                       color: Colors.red
//                   ),),)
//                       :
//                   const SizedBox(height: 12),
//
//
//                   const SizedBox(height: 12),
//                         SearchTextFieldWidget(
//                       color: kBtnColor.withOpacity(0.8),
//                       textEditingController: controller.searchTextController,
//                       onTap: () {
//                         controller.createStory();
//                         controller.searchTextController.clear();
//
//                       }),
//                   const SizedBox(height: 20),
//
//                 ],
//               ),
//             ),
//           )
//     );
//   }
// }
//
//
// class TextCard extends StatelessWidget {
//   TextCard({Key? key, this.textData ,this.index}) : super(key: key);
//
//   var textData;
//   var index;
//
//   RxList<RxBool> list =<RxBool>[].obs;
//   @override
//   Widget build(BuildContext context) {
//     return
//       InkWell(
//         onTap: (){    tts.speak(textData.story);},
//         onDoubleTap: (){
//           tts.stop();
//         },
//         child: Container(
//           color: kBtnColor.withOpacity(0.1),
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // Container(
//                     //   height: 40,
//                     //   width: 40,
//                     //   decoration: BoxDecoration(
//                     //       color: Colors.green.withOpacity(0.9),
//                     //       borderRadius: BorderRadius.circular(100)),
//                     //   child: const Icon(
//                     //     Icons.ac_unit,
//                     //     color: Colors.white,
//                     //   ),
//                     // ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         textData.story??"No Story Found",
//                         style: const TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     // InkWell(
//                     //     onTap: () {
//                     //       Share.share(textData.text);
//                     //     },
//                     //     child: const Icon(Icons.share, size: 28)),
//                     const SizedBox(width: 20),
//                     InkWell(
//                         onTap: () {
//                           Clipboard.setData(ClipboardData(text: textData.story.toString()));
//                         },
//                         child: const Icon(Icons.copy, size: 28)),
//                     const SizedBox(width: 20),
//                     //
//                     // InkWell(
//                     //     onTap: () {
//                     //       tts.speak(textData.text);
//                     //       tts.setCompletionHandler(() {
//                     //         list[index].value=false;
//                     //       });
//                     //     },
//                     //     child:list[index].value==false? const Icon(Icons.pause, size: 28): const Icon(Icons.play_arrow, size: 28)),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//               ],
//             ),
//           ),
//         ),
//       );
//   }
// }
//
// class MyTextCard extends StatelessWidget {
//   MyTextCard({Key? key, this.title}) : super(key: key);
//
//   var title;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             height: 40,
//             width: 40,
//             decoration: BoxDecoration(
//                 color: Colors.green.withOpacity(0.9),
//                 borderRadius: BorderRadius.circular(100)),
//             child: const Icon(
//               Icons.person,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//              // controller.searchTextController.text,
//               title ?? "No Title Found!",
//               style: const TextStyle(fontSize: 18),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class SearchTextFieldWidget extends StatelessWidget {
//   final TextEditingController? textEditingController;
//   final VoidCallback? onTap;
//   var color;
//
//   SearchTextFieldWidget({
//     Key? key,
//     this.color,
//     this.textEditingController,
//     this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return _searchTextField();
//   }
//
//   Widget _searchTextField() {
//     return Container(
//       // margin: const EdgeInsets.only(bottom: 6, left: 0, right: 0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Expanded(
//             child: Container(
//               // margin: const EdgeInsets.only(left: 8),
//               decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: kBtnColor.withOpacity(.2),
//                       offset: const Offset(0.0, 0.50),
//                       spreadRadius: 1,
//                       blurRadius: 1,
//                     )
//                   ]),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       const SizedBox(width: 20),
//                       Expanded(
//                         child: ConstrainedBox(
//                           constraints: const BoxConstraints(maxHeight: 60),
//                           child: Scrollbar(
//                             child: TextField(
//                               style: const TextStyle(fontSize: 14),
//                               controller: textEditingController,
//                               maxLines: null,
//                               decoration: const InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText:
//                                   "Type Your Story Title Here..."),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 15),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(width: 5),
//           InkWell(
//             // onTap:(){
//             //
//             //   controller.createStory();
//             //
//             // },
//             onTap:onTap,
//             child: Container(
//               decoration: BoxDecoration(
//                   color: color, borderRadius: BorderRadius.circular(40)),
//               padding: const EdgeInsets.all(10),
//               child: const Icon(
//                 Icons.send,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           // const SizedBox(width: 6)
//         ],
//       ),
//     );
//   }
// }