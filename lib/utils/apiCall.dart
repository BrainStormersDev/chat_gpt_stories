import 'dart:convert';

import '../../model/login_model.dart';
import '../../view/Pages/login_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'MyRepo.dart';
import 'mySnackBar.dart';

// class ApiCalls {
//   static Future apiCall(String endpoint, String method, Object? apiBody) async {
//     var response;
//     Connectivity connectivity = Connectivity();
//     ConnectivityResult result = ConnectivityResult.none;
//     try {
//       result = await connectivity.checkConnectivity();
//       print("-------internet result :${result.toString()}---------");
//     } on PlatformException catch (e) {
//       print(e.toString());
//     }
//     switch (result) {
//       case ConnectivityResult.none:
//         MySnackBar.snackBarRed(title: "Alert", message: "Not internet connection found");
//         break;
//       case ConnectivityResult.wifi:
//         break;
//       case ConnectivityResult.mobile:
//       case ConnectivityResult.bluetooth:
//         // TODO: Handle this case.
//         break;
//       case ConnectivityResult.ethernet:
//         // TODO: Handle this case.
//         break;
//       case ConnectivityResult.vpn:
//         // TODO: Handle this case.
//         break;
//     }
//     ///change true method required from user method like post or get or other
//     if (method=="post") {
//       response = await http.post(
//           Uri.parse(
//             endpoint,
//           ),
//           body: apiBody).timeout(const Duration(seconds: 10), onTimeout: () {
//             print("======= request time out ");
//         return http.Response('Error', 503);
//       });
//     }
//     print("===== status code ${response.statusCode} ");
//     if(response.statusCode==200){
//       var jsonDecodeData=jsonDecode(response.body);
//       if(jsonDecodeData["status"]==true){
//         MySnackBar.snackBarYellow(title: "Alert", message: "${jsonDecodeData["message"]}");
//       }
//       print("=======jsonDecodeData ${await jsonDecodeData}");
//     }
//     else if (response.statusCode == 500) {
//       // print("====before==========${(json.decode(response.body)['message'])}");
//       MySnackBar.snackBarRed(
//           title: "Alert", message: "Internal Server error");
//     }
//     else if (response.statusCode == 502 || response.statusCode == 503  || response.statusCode == 302) {
//       print("===== status code ${response.statusCode} ");
//       MySnackBar.snackBarRed(
//           title: "Alert", message: "Time Out Due to Internet Connectivity");
//     }
//   }
// }

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
      print(e.toString());
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
          // print("====before==========${(json.decode(response.body)['message'])}");
          MySnackBar.snackBarRed(
              title: snackTitle, message: "Internal Server error");
          return {
            'isData': false,
            'message': "Internal Server error"
            // 'message':"Internal Server error"
          };
        }
        else if (response.statusCode == 200) {
          print("============== status code 200");
          if (json.decode(response.body)['status_code'] == 808) {
            print("========Session Out :$endpoint=======");
            MySnackBar.snackBarSessionOut(
                title: "Session Out",
                message: "You have session out please login again");
            Get.offAll(()=>LogInPage());
            GetStorage().remove("userName");
            return {
              'isData': false,
              'message': json.decode(response.body)['message']
            };
          }
          else if (json.decode(response.body)['status']==true) {

              MySnackBar.snackBarPrimary(
                  title: snackTitle,
                  message: json.decode(response.body)['message'] ??
                      "Successfully done");

            return {
              'isData': true,
              'response': response.body,
              'message': json.decode(response.body)['message']
            };
          }
          else {
            if (isSnackBarShow) {
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
}






/// api call
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/response/response.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
// import 'package:http/http.dart' as Http;
// import '../../base_url/base_url.dart';
// import '../../noInternet/no_internet.dart';
// import '../response/error_response.dart';
// class ApiClient extends GetxService {
//   static const String noInternetMessage = 'Connection to API server failed due to internet connection';
//   final int timeoutInSeconds = 30;
//   late String token;
//   Future<Response> postData(String uri, dynamic body,dynamic headers ) async {
//     try {
//       debugPrint('====> API Call: $uri');
//       debugPrint('====> API Body: $body');
//       Http.Response _response = await Http.post(
//         Uri.parse(BaseApi().baseUrl+uri),
//         headers: headers,
//         body: body,
//       ).timeout(Duration(seconds: timeoutInSeconds));
//       print("====postData==>:${_response.statusCode}===========");
//       return handleResponse(_response, uri);
//     } catch (e) {
//       print("======ApiClient error:$e===========");
//       // Get.dialog(ErrorDialog().noInternetDialogue(navigatorKey.currentContext!, noInternetMessage));
//       return const Response(statusCode: 1, statusText: noInternetMessage);
//     }
//   }
//   Future<Response> getData(String uri,dynamic header) async {
//     try {
//       debugPrint('====> API Call: $uri');
//       Http.Response _response = await Http.get(
//           Uri.parse(BaseApi().baseUrl+uri),headers:header
//       ).timeout(Duration(seconds: timeoutInSeconds));
//       return handleResponse(_response, uri);
//     } catch (e) {
//       print("======ApiClient error:$e===========");
//       return const Response(statusCode: 1, statusText: noInternetMessage);
//     }
//   }
//   Response handleResponse(Http.Response response, String uri) {
//     dynamic _body;
//     try {
//       _body = jsonDecode(response.body);
//     }catch(e) {
//       print("=====ApiClient:=error:$e=============");
//
//     }
//     Response _response = Response(
//       body: _body ?? response.body,
//       bodyString: response.body.toString(),
//       headers: response.headers,
//       statusCode: response.statusCode,
//       statusText: response.reasonPhrase,
//     );
//     if(_response.statusCode != 200 && _response.body != null && _response.body is !String) {
//       if(_response.body.toString().startsWith('{errors: [{code:')) {
//         // debugPrint('====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
//         ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
//         _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.errors[0].message);
//       }else if(_response.body.toString().startsWith('{message')) {
//         _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
//       }
//     }else if(_response.statusCode != 200 && _response.body == null) {
//       _response =  const Response(statusCode: 0, statusText: noInternetMessage);
//       debugPrint('====> API Response: [${_response.statusText}] $uri\n${_response.body}');
//     }
//     // _response=Response(statusText: _response.statusText,body:{_response.body} );
//     debugPrint('====> API Response: [${_response.statusCode}] $uri \n${_response.body}');
//     return _response;
//   }
// }

