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
    // try {
    //   // Map<String, String> rowParams = {
    //   //   "model": "text-curie-001",
    //   //   // "model": "text-davinci-003",
    //   //   "prompt": query,
    //   // };
    //
    //   // final encodedParams = json.encode(rowParams);
    //
    //
    //   final response = await http.post(
    //     Uri.parse("${kBaseUrl}login"),
    //     body: {
    //       "email": "farmaan@thebrainstormers.org",
    //       "password": "12345678",
    //     },
    //     // body: json.encode({
    //     //   "search": 'Princes',
    //     // }),
    //
    //
    //
    //     // body: json.encode({
    //     //   "model": "text-davinci-003",
    //     //   "prompt": query,
    //     //   'temperature': 0,
    //     //   'max_tokens': 4000,
    //     //   'top_p': 1,
    //     //   'frequency_penalty': 0.0,
    //     //   'presence_penalty': 0.0,
    //     // }),
    //     // body: encodedParams,
    //
    //     // headers: headerBearerOption(MyRepo.kApiToken.value),
    //   );
    //   print("Response   getTextCompletion====  ${response.body}");
    //
    //   if (response.statusCode == 200) {
    //     // messages =
    //     //     TextCompletionModel.fromJson(json.decode(response.body)).choices;
    //     //
    //     // addServerMessage(
    //     //     TextCompletionModel.fromJson(json.decode(response.body)).choices);
    //  // Rx<LogIn>   logInModel =LogIn(status: false,message: '',data: ).obs;
    //     // // getStoryModels =GetStoryModels(status: false,message: '',data: DataOfStory(story: '',images: [])).obs;
    //     //
    //     // storyCategoryListModels.value =StoryCatListModel.fromJson(json.decode(response.body));
    //     // // getStoryModels.value =GetStoryModels.fromJson(json.decode(response.body));
    //     // print("Response $query  getTextCompletion====  ${response.body}");
    //     //
    //     state.value = ApiState.success;
    //   } else {
    //     // throw ServerException(message: "Image Generation Server Exception");
    //     state.value = ApiState.error;
    //     // errorMsg.value = "Error :${storyCategoryListModels.value.message}";
    //
    //
    //   }
    // } catch (e) {
    //   print("Errorrrrrrrrrrrrrrr  ");
    //
    //   state.value = ApiState.error;
    //   // errorMsg.value = "Error :$e";
    // } finally {
    //   // searchTextController.clear();
    //   update();
    // }
  }
}