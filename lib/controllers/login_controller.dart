import '../../model/login_model.dart';
import '../../utils/apiCall.dart';
import 'package:get/get.dart';

import '../common/headers.dart';
import 'package:http/http.dart' as http;
import '../utils/MyRepo.dart';
class LogInContoller extends GetxController{

  var state = ApiState.notFound.obs;
  Rx<LogIn> logInModel=LogIn().obs;

  @override
  void onInit() {
    print("========fff========");
    getLogIn();
    super.onInit();
  }

  getLogIn(
      // {required String query, required String catId}
      ) async {


    // print("=======query:${query}=========");
    // addMyMessage();
   var body= {
      "email": "farmaan@thebrainstormers.org",
    "password": "12345678",
    };
    state.value = ApiState.loading;
ApisCall.apiCall("${kBaseUrl}login", "post", body);

  }
}