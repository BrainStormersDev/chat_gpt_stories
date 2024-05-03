import 'dart:convert';
import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;

late PackageInfo packageInfo;
String version = '';
bool versionMismatch = false;
var playStoreUrl = '';

Future<void> versionCheck() async {

  packageInfo = await PackageInfo.fromPlatform();
  var url;

    print('package build number ${packageInfo.buildNumber}');
    print('package package version ${packageInfo.version}');
    version = packageInfo.version; //+'\n'+Platform.operatingSystemVersion;
    // print("============packageInfo.version:${packageInfo.version}=====================");

  url = Uri.parse("http://gptstory.thebrainstormers.org/api/v1/version");

  final response = await http.get(url);
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    /// if platform is android( android or huawei)
    if (Platform.isAndroid) {
      /// gpt_huawei_app_version is used for both android and huawei mobiles.
      /// if package version is not equal to the version get from server (api).
      if (packageInfo.version != data['data']["staff_huawei_app_version"])
      {
        /// if status is 0 means app is live for users and version mismatch
        /// means you must have to update the app
        if ((data['data']["staff_huawei_status"] == 0))
        {
            versionMismatch=true;
            playStoreUrl = data['data']["staff_huawei_app_url"];


        }
        /// if status is 1 means app is live for internal testers only
        /// go to play store and update the app.
        else if(data['data']["staff_huawei_status"] == 1)
        {
          print("version is changed and app is in internal testing.");
        }
      }
      else
      {
        /// app package version and server api version are same means app is updated.
      }
    }
    /// if platform is ios

    else if (Platform.isIOS) {
      /// staff_iphone_app_version is used for ios.
      /// if package version is not equal to the version get from server (api).
      if (packageInfo.version != data['data']["staff_iphone_app_version"]) {
        /// if status is 0 means app is live for users and version mismatch
        /// means you must have to update the app
        if (data['data']["staff_ios_status"] == 0) {

            versionMismatch = true;
            playStoreUrl = data['data']["staff_iphone_app_url"].toString();
        }
        /// if status is 1 means app is live for internal testers only
        /// go to play store and update the app.
        if (data['data']["staff_ios_status"] == 1) {
          print("version is changed and app is in internal testing.");

        }

      }
      else
      {
        /// app package version and server api version are same means app is updated.

      }
    }
  }

  if (Platform.isAndroid) {
    // Position _position = await _determinePosition();
  }
}
