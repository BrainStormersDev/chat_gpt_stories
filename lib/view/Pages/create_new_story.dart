import 'package:get_storage/get_storage.dart';
import '../../controllers/CreateStoryController.dart';
import '../../utils/my_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import '../../common/headers.dart';
import '../../utils/MyRepo.dart';
import '../../utils/app_color.dart';
import '../Widgets/constWidgets.dart';
///test
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// const String apiKey = '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';
//
// class CreateNewStory extends StatefulWidget {
//   @override
//   _CreateNewStoryState createState() => _CreateNewStoryState();
// }
//
// class _CreateNewStoryState extends State<CreateNewStory> {
//   TextEditingController _questionController = TextEditingController();
//   String _answer = '';
//
//   Future<void> _getAnswer() async {
//     String question = _questionController.text;
//     if (question.isNotEmpty) {
//       String apiUrl = 'https://api.openai.com/v1/engines/davinci-codex/completions';
//       Map<String, String> headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $apiKey',
//       };
//       Map<String, dynamic> body = {
//         'prompt': 'Question: $question\nAnswer:',
//         'max_tokens': 200,
//         'temperature': 0.5,
//         'top_p': 1.0,
//         'n': 1,
//         'stop': '\n',
//       };
//
//       try {
//         http.Response response = await http.post(
//           Uri.parse(apiUrl),
//           headers: headers,
//           body: jsonEncode(body),
//         );
//         if (response.statusCode == 200) {
//           Map<String, dynamic> responseData = jsonDecode(response.body);
//           setState(() {
//             _answer = responseData['choices'][0]['text'];
//           });
//         } else {
//           setState(() {
//             _answer = 'Error occurred while fetching the answer.';
//           });
//         }
//       } catch (e) {
//         print('Error: $e');
//         setState(() {
//           _answer = 'Error occurred while fetching the answer.';
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Question-Answering'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _questionController,
//               decoration: InputDecoration(
//                 labelText: 'Enter a question',
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _getAnswer,
//             child: Text('Get Answer'),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   _answer,
//                   style: TextStyle(fontSize: 16.0),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

///final
FlutterTts tts = FlutterTts();

class CreateNewStory extends StatelessWidget {
   CreateNewStory({Key? key}) : super(key: key);
  CreateStoryController controller =Get.put(CreateStoryController());
  @override
  Widget build(BuildContext context) {
    logger.i(GetStorage().read("bearerToken"));

    return Scaffold(
      backgroundColor: AppColors.kScreenColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: storyByGptWidget(context),
        centerTitle: true,
        backgroundColor: AppColors.kScreenColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // Get.close(1);
            // Get.off(()=>StoryViewPage(data: MyRepo.currentStory));
          },
          icon: InkWell(
            onTap: (){
              tts.stop();
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.txtColor1,
            ),
          ),
        ),
      ),
      body:
          Obx(()=>
             Padding(
              padding:
              const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  const  Center(
                    child:  Text(
                      "Create Your Own Story",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "BalooBhai",
                          color: AppColors.txtColor1),
                    ),
                  ),
                  Expanded(
                    child: controller.allStoryData.isEmpty
                        ?
                    const Center(child: Text("No Story Created Yet",    style: TextStyle(
                        fontFamily: "BalooBhai",
                        color: AppColors.kGrey),),)
                        :
                    ListView.builder(
                      reverse: true,
                      itemCount: controller.allStoryData.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final textData = controller.allStoryData[index];
                        final title = controller.storyTitle[index];
                        // logger.e(title);
                        return
                          textData.id==null
                            ?
                          MyTextCard(title: title)
                            :
                          TextCard(textData: textData);
                      },
                    ),
                  ),
                  controller.state.value == ApiState.loading
                      ?
                  Center(child: myIndicator())
                  :
                  controller.state.value == ApiState.error
                  ?
                  Container(child: Text('Something went wrong.Try again', style: TextStyle(
                      color: Colors.red
                  ),),)
                      :
                  const SizedBox(height: 12),


                  const SizedBox(height: 12),
                        SearchTextFieldWidget(
                      color: AppColors.kBtnColor.withOpacity(0.8),
                      textEditingController: controller.searchTextController,
                      onTap: () {
                        controller.createStory();
                        controller.searchTextController.clear();

                      }),
                  const SizedBox(height: 20),

                ],
              ),
            ),
          )
    );
  }
}


class TextCard extends StatelessWidget {
  TextCard({Key? key, this.textData ,this.index}) : super(key: key);

  var textData;
  var index;

  RxList<RxBool> list =<RxBool>[].obs;
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: (){    tts.speak(textData.story);},
        onDoubleTap: (){
          tts.stop();
        },
        child: Container(
          color: AppColors.kBtnColor.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //   height: 40,
                    //   width: 40,
                    //   decoration: BoxDecoration(
                    //       color: Colors.green.withOpacity(0.9),
                    //       borderRadius: BorderRadius.circular(100)),
                    //   child: const Icon(
                    //     Icons.ac_unit,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        textData.story??"No Story Found",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // InkWell(
                    //     onTap: () {
                    //       Share.share(textData.text);
                    //     },
                    //     child: const Icon(Icons.share, size: 28)),
                    const SizedBox(width: 20),
                    InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: textData.story.toString()));
                        },
                        child: const Icon(Icons.copy, size: 28)),
                    const SizedBox(width: 20),
                    //
                    // InkWell(
                    //     onTap: () {
                    //       tts.speak(textData.text);
                    //       tts.setCompletionHandler(() {
                    //         list[index].value=false;
                    //       });
                    //     },
                    //     child:list[index].value==false? const Icon(Icons.pause, size: 28): const Icon(Icons.play_arrow, size: 28)),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
  }
}

class MyTextCard extends StatelessWidget {
  MyTextCard({Key? key, this.title}) : super(key: key);

  var title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.9),
                borderRadius: BorderRadius.circular(100)),
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
             // controller.searchTextController.text,
              title ?? "No Title Found!",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchTextFieldWidget extends StatelessWidget {
  final TextEditingController? textEditingController;
  final VoidCallback? onTap;
  var color;

  SearchTextFieldWidget({
    Key? key,
    this.color,
    this.textEditingController,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _searchTextField();
  }

  Widget _searchTextField() {
    return Container(
      // margin: const EdgeInsets.only(bottom: 6, left: 0, right: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              // margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.kBtnColor.withOpacity(.2),
                      offset: const Offset(0.0, 0.50),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Expanded(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 60),
                          child: Scrollbar(
                            child: TextField(
                              style: const TextStyle(fontSize: 14),
                              controller: textEditingController,
                              maxLines: null,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                  "Type Your Story Title Here..."),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          InkWell(
            // onTap:(){
            //
            //   controller.createStory();
            //
            // },
            onTap:onTap,
            child: Container(
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(40)),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
          // const SizedBox(width: 6)
        ],
      ),
    );
  }
}