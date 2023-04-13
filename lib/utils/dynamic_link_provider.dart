
import 'package:chat_gpt_stories/controllers/story_cat_controller.dart';
import 'package:chat_gpt_stories/view/Pages/rate_us_page.dart';
import 'package:chat_gpt_stories/view/Pages/story_catList_page.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/chat_text_controller.dart';

StoryCatController dynamicStoryCatController =Get.put(StoryCatController());
class DynamicLinksProvider {
  // final String url = "https://brainstormers.gpt_stories?ref=52565";


  ///Create Link
  Future<String> createLink (String catName, String name) async{
    final String url = "https://brainstormers.gpt_stories?catName=$catName&name=$name";


    final DynamicLinkParameters parameters = DynamicLinkParameters(
      androidParameters: const AndroidParameters(packageName: 'com.brainstormers.gpt_stories', minimumVersion: 0),
        iosParameters: const IOSParameters(bundleId: 'com.brainstormers.gpt_stories', minimumVersion: "0"),
        link: Uri.parse(url), uriPrefix: "https://gptstoriesforkids.page.link");
    final FirebaseDynamicLinks links = FirebaseDynamicLinks.instance;
    final refLink = await links.buildShortLink(parameters);

    return refLink.shortUrl.toString();
  }
  ///init Dynamic Link


  void initDynamicLink () async{
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();

    if(instanceLink != null){

      print("navigate to cat page============");
      final Uri refLink = instanceLink.link;
      print("======name ======${refLink.queryParameters}");
      // nextPage(catName: "Animals", name: "The Lion and the Friends");
      nextPage(catName: "${refLink.queryParameters["catName"]}", name: "${refLink.queryParameters["name"]}");
      // Share.share("this is the link== ${refLink.queryParameters["ref"]} == ${refLink.queryParameters["name"]}");

    }

  }


  nextPage({required name, required catName}) async {


    String searchText ='$name';
    // String searchText ='$name';
    // String catId = '${data.id}';
    String catN = '$catName';
    // String searchText ='Story of ${data.title} for children';


    // await MyRepo.assetsAudioPlayer.pause();
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.put(ChatTextController()).getTextCompletion(query: searchText, catId: "");
      // Get.put(ChatImageController()).getGenerateImages(searchText);
      Get.to(StoryCatList(catName: catN,));
    });
  }


}