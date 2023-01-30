import 'package:chat_gpt_stories/view/Pages/rate_us_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/app_color.dart';

class StoryViewPage extends StatelessWidget {
  const StoryViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kScreenColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.kScreenColor,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: AppColors.txtColor1,), ),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RateUsPage()));
              },
              icon: const Icon(CupertinoIcons.star, color: AppColors.kBtnColor,))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 27,
                        child: Image.asset("assets/PNG/gridIcon.png")),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                    const Text(
                      "Story ",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "BalooBhai",
                          color: AppColors.kBtnColor),
                    ),
                    const Text(
                      "By Chat GPT",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "BalooBhai",
                          color: AppColors.txtColor1),
                    ),
                    const Spacer(),
                    SizedBox(
                        height: 30,
                        child: Image.asset("assets/PNG/bellIcon.png")),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        // height: MediaQuery.of(context).size.height * 0.1,
                        // width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.kBtnColor, width: 1)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 4, bottom: 4, right: 8),
                          child: Text(
                            "Cinderella ",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: "BalooBhai",
                                color: AppColors.kBtnColor),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: Image.asset("assets/PNG/loin.png")),
                  ],
                ),
                Text(
                   "It is a long established fact that a reader will be distracted",
                   style: TextStyle(color: AppColors.txtColor2, fontSize: 17),
                   textAlign: TextAlign.start,
                 ),
                const SizedBox(height: 10,),
                SizedBox(
                    // height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.asset("assets/PNG/img.png")),
                const SizedBox(height: 10,),
                Text(
                  "by the readable content of a page when looking at its layout.",
                  style: TextStyle(color: AppColors.txtColor2, fontSize: 17),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.asset("assets/PNG/img_1.png")),
                const SizedBox(height: 10,),
                Text(
                  "dable English. Many desktop publishing ",
                  style: TextStyle(color: AppColors.txtColor2, fontSize: 17),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.asset("assets/PNG/img_2.png")),
                const SizedBox(height: 35,),
              ],
            ),
          ),
        ),
      ),
    );;
  }
}
