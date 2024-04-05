import 'dart:convert';
import '../../view/Pages/login_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'MyRepo.dart';
import 'mySnackBar.dart';

class ApisCall {


  static Future apiCall(String endpoint, String method, Object? apiBody,
      {bool isSnackBarShow = false,
      String snackTitle = "Alert",
      isNoInterMsg = false,
        String header="",
      }) async {
    var url = Uri.parse(endpoint);
    //internet check
    var response;
    Connectivity _connectivity = Connectivity();
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
      print("-------internet result :${result.toString()}---------");
    } on PlatformException catch (e) {
      print(" internet connection issue:${e.toString()}");
    }
    switch (result) {
      case ConnectivityResult.none:
        print("--------no internet---------");
          MySnackBar.snackBarRed(
              title: snackTitle, message: "Not internet connection found");

        return {'isData': false, 'message': "Not internet connection found"};
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        //api call
        if (method == "post") {
          response = await http
              .post(
            url,
            body: apiBody,
          )
              .timeout(const Duration(seconds: 20), onTimeout: () {
                logger.e("timeout");
               return http.Response('Error', 503);
          });
        } else if (method == "get") {
          response = await http.get(
            url,
            headers: {"token":header}
          );
        }
        print("====== prob start  ${response.statusCode}==");
        if (response.statusCode == 500) {
          print("======response ($url ) :${response.body}=======");
          MySnackBar.snackBarRed(
              title: snackTitle, message: "Internal Server error");
          return {
            'isData': false,
            'message': "Internal Server error"
            // 'message':"Internal Server error"
          };
        }
        else if (response.statusCode == 200) {
          print("status code 200");
          if (json.decode(response.body)['status_code'] == 808) {
            print("========Session Out :$endpoint=======");
            MySnackBar.snackBarSessionOut(
                title: "Session Out",
                message: "You have session out please login again");
            GetStorage().remove("userName");
            Get.offAll(()=>LogInPage());

            return {
              'isData': false,
              'message': json.decode(response.body)['message']
            };
          }
          else if (json.decode(response.body)['status']==true) {
            print("status true");

              // MySnackBar.snackBarPrimary(
              //     title: snackTitle,
              //     message: json.decode(response.body)['message'] ??
              //         "Successfully done");

            return {
              'isData': true,
              'response': response.body,
              'message': json.decode(response.body)['message']
            };
          }
          else {
            if (isSnackBarShow) {
              print("message here");
              MySnackBar.snackBarRed(
                  title: snackTitle,
                  message: json.decode(response.body)['message'] ?? "Error! ");
            }

            return {
              'isData': false,
              'response': response.body,
              'message': json.decode(response.body)['message']
            };
          }
        }
        else if (response.statusCode ==201) {
          MySnackBar.snackBarYellow(title: "Successfully", message: json.decode(response.body)['messages']);
          return {
            'isData': true,
            'message': json.decode(response.body)['message']
            // 'message':"Internal Server error"
          };
        }
        else if (response.statusCode ==401) {
          MySnackBar.snackBarRed(title: "Alert", message: json.decode(response.body)['message']);
          return {
            'isData': false,
            'message': json.decode(response.body)['message']
            // 'message':"Internal Server error"
          };
        }
        else if (response.statusCode == 302 ) {
          print("============== 302  ${response.body}");
          print("============== 302 422 ${json.decode(response.body)['message']}");
          MySnackBar.snackBarRed(
              title: snackTitle,
              message: json.decode(response.body)['message']);
          return {
            'isData': false,
            'message': json.decode(response.body)['message']
            // 'message':"Internal Server error"
          };
        }
        else if (response.statusCode == 422 ) {
          print("============== 302  ${response.body}");
          print("============== 302 422 ${json.decode(response.body)['message']}");
          MySnackBar.snackBarRed(
              title: snackTitle,
              message: json.decode(response.body)['message']);
          return {
            'isData': false,
            'message': json.decode(response.body)['message']
            // 'message':"Internal Server error"
          };
        }
        else if (response.statusCode == 502 || response.statusCode == 503) {
          MySnackBar.snackBarYellow(title: "Alert", message: "Time Out Due to Internet Connectivity");
          return {
            'isData': false,
            'message': "Time Out Due to Internet Connectivity"
            // 'message':"Internal Server error"
          };
        }
        else if (response.statusCode == 404) {
          MySnackBar.snackBarRed(
              title: snackTitle,
              message: json.decode(response.body)['message'] ?? "Error! ");
          return {
            'isData': false,
            'message': json.decode(response.body)['message']
            // 'message':"Internal Server error"
          };
        }
        else {
          print("else part============");
          MySnackBar.snackBarPrimary(
              title: snackTitle, message: "Some thing went wrong");
          return {'isData': false, 'message': "Some thing went wrong"};
        }
      default:
        if (isSnackBarShow) {
          MySnackBar.snackBarRed(
              title: snackTitle, message: "Some thing went wrong");
        }
        return {'isData': false, 'message': "Some thing went wrong"};
    }
  }

  static Future multiPartApiCall(String endpoint, String method, Map<String,String> apiBody,
      {bool isSnackBarShow = false,
        String snackTitle = "Alert",
        isNoInterMsg = false,
        Map<String, String>? header,
      }) async {
    var url = Uri.parse(endpoint);
    //internet check
    var response;
    String stringResponse = '';

    Connectivity _connectivity = Connectivity();
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
      print("-------internet result :${result.toString()}---------");
    } on PlatformException catch (e) {
      print("error in network: ${e.toString()}");
    }
    switch (result) {
      case ConnectivityResult.none:
        print("--------no internet---------");
        MySnackBar.snackBarRed(
            title: snackTitle, message: "Not internet connection found");

        return {'isData': false, 'message': "Not internet connection found"};
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      ///api call post

        if (method == "post") {
logger.i(" url and header: ${url} ${header} ${apiBody}");
          var request = http.MultipartRequest('POST', url);
          if(header!=null)
          request.headers.addAll(header);
          request.fields.addAll(apiBody);
          try{
           response = await request.send();}
          catch(e){
            print("error in network: ${e.toString()}");

          }
          stringResponse = await response.stream.bytesToString();
        }


        ///api call get

        else if (method == "get") {
          var request = http.MultipartRequest('GET', url);
          if(header!=null)
            request.headers.addAll(header);
          response = await request.send();
          stringResponse = await response.stream.bytesToString();

        }
        print("====== prob start  ${response.statusCode}= ${stringResponse} = ");

        if (response.statusCode == 500) {
          print("======response ($url ) :${response.body}=======");
          MySnackBar.snackBarRed(
              title: snackTitle, message: "Internal Server error");
          return {
            'isData': false,
            'message': "Internal Server error"
            // 'message':"Internal Server error"
          };
        }
        else if (response.statusCode == 200) {
          print("status code 200");
          print(json.decode(stringResponse)['status']);
          if (json.decode(stringResponse)['status_code'] == 808) {
            print("========Session Out :$endpoint=======");
            MySnackBar.snackBarSessionOut(
                title: "Session Out",
                message: "You have session out please login again");
            GetStorage().remove("userName");
            Get.offAll(()=>LogInPage());

            return {
              'isData': false,
              'message': json.decode(response.body)['message']
            };
          }
          else if (json.decode(stringResponse)['status']==true) {

            // MySnackBar.snackBarYellow(
            //     title: snackTitle,
            //     message: json.decode(stringResponse)['message'] ??
            //         "Successfully done");

            return {
              'isData': true,
              'response': stringResponse,
              'message': json.decode(stringResponse)['message']
            };
          }
          else {
            if (isSnackBarShow) {
              MySnackBar.snackBarRed(
                  title: snackTitle,
                  message: json.decode(stringResponse)['message'] ?? "Error! ");
            }

            return {
              'isData': false,
              'response': stringResponse,
              'message': json.decode(stringResponse)['message']
            };
          }
        }
        else if (response.statusCode ==201) {
          MySnackBar.snackBarYellow(title: "Successfully", message: json.decode(stringResponse)['message']);
          return {
            'isData': true,
            'message': json.decode(stringResponse)['message']

          };
        }
        else if (response.statusCode ==401) {
          MySnackBar.snackBarRed(title: "Alert", message: json.decode(stringResponse)['message']);
          return {
            'isData': false,
            'message': json.decode(stringResponse)['message']
            // 'message':"Internal Server error"
          };
        }
        else if (response.statusCode == 302 ) {
          print("============== 302  ${stringResponse}");
          print("============== 302 422 ${json.decode(stringResponse)['message']}");
          MySnackBar.snackBarRed(
              title: snackTitle,
              message: json.decode(stringResponse)['message']);
          return {
            'isData': false,
            'message': json.decode(stringResponse)['message']
            // 'message':"Internal Server error"
          };
        }
        else if (response.statusCode == 422 ) {
          print("============== 302  ${stringResponse}");
          print("============== 302 422 ${json.decode(stringResponse)['message']}");
          MySnackBar.snackBarRed(
              title: snackTitle,
              message: json.decode(stringResponse)['message']);
          return {
            'isData': false,
            'message': json.decode(stringResponse)['message']
            // 'message':"Internal Server error"
          };
        }
        else if (response.statusCode == 502 || response.statusCode == 503) {
          MySnackBar.snackBarYellow(title: "Alert", message: "Time Out Due to Internet Connectivity");
          return {
            'isData': false,
            'message': "Time Out Due to Internet Connectivity"
            // 'message':"Internal Server error"
          };
        }
        else if (response.statusCode == 404) {
          MySnackBar.snackBarRed(
              title: snackTitle,
              message: json.decode(stringResponse)['message'] ?? "Error! ");
          return {
            'isData': false,
            'message': json.decode(stringResponse)['message']
            // 'message':"Internal Server error"
          };
        }
        else {
          print("else part============");
          MySnackBar.snackBarRed(
              title: snackTitle, message: "Some thing went wrong");
          return {'isData': false, 'message': "Some thing went wrong"};
        }
      default:
        if (isSnackBarShow) {
          MySnackBar.snackBarRed(
              title: snackTitle, message: "Some thing went wrong");
        }
        return {'isData': false, 'message': "Some thing went wrong"};
    }
  }
}

