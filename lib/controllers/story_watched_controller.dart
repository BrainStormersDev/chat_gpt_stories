//
// import '../../utils/apiCall.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import '../common/headers.dart';
// import '../model/myStoriesModel.dart';
// import '../model/storyCatListModel.dart';
//
// class StoryWatchedController extends GetxController {
//   //TODO: Implement ChatTextController
//   RxString filter = ''.obs;
//   var state = ApiState.notFound.obs;
//   Rx<StoryCatListModel> myStoriesModels = StoryCatListModel(status: false, message: '', data: []).obs;
//   var token;
//
//   @override
//   Future<void> onInit() async {
//     print("========fff========");
//
//     super.onInit();
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
//
//   ///watched stories
//   // Future<void> getWatchedStory() async {
//   //   print("========= MyRepo.bearerToken :${GetStorage().read("bearerToken")}");
//   //   if (GetStorage().read("bearerToken").toString().isNotEmpty) {
//   //     token = GetStorage().read("bearerToken");
//   //   }
//   //   print("============== <token> $token");
//   //   var headers = {
//   //     'Accept': 'application/json',
//   //     'Content-Type': 'application/json',
//   //     'Authorization': 'Bearer $token'
//   //   };
//   //   var request = http.MultipartRequest(
//   //       'GET',
//   //       Uri.parse(
//   //           'http://gptstory.thebrainstormers.org/api/v1/user/viewed-stories'));
//   //   request.headers.addAll(headers);
//   //   http.StreamedResponse response = await request.send();
//   //   if (response.statusCode == 200) {
//   //     var res = await response.stream.bytesToString();
//   //     storyCategoryModels.value = StoryWatchedModel.fromJson(json.decode(res));
//   //     print("=========== length :${storyCategoryModels.value.data!.length}");
//   //   } else {
//   //     print("get watched stories ${response.reasonPhrase}");
//   //   }
//   //
//   //   print("=========  statis code ${response.statusCode}");
//   //   print("=========  response.body22 ${storyCategoryModels.value.message}");
//   // }
//
//   ///get my stories
//   Rx<MyStoriesModel> myStoriesModel = MyStoriesModel(status: false, data: []).obs;
//
//   // Future<void> getMyStories() async {
//   //   state.value=ApiState.loading;
//   //   print("========= MyRepo.bearerToken :${GetStorage().read("bearerToken")}");
//   //   if (GetStorage().read("bearerToken").toString().isNotEmpty) {
//   //     token = GetStorage().read("bearerToken");
//   //   }
//   //   var headers = {
//   //     'Accept': 'application/json',
//   //     'Content-Type': 'application/json',
//   //     'Authorization': 'Bearer $token'
//   //   };
//   //
//   //   try {
//   //     await ApisCall.multiPartApiCall(
//   //             "http://gptstory.thebrainstormers.org/api/v1/user/story/list",
//   //             'get',
//   //             {},
//   //             header: headers)
//   //         .then((value) {
//   //       if (value["isData"]) {
//   //         myStoriesModels.value=storyCatListModelFromJson(value["response"]);
//   //         state.value=ApiState.success;
//   //       } else {
//   //         state.value=ApiState.error;
//   //
//   //       }
//   //     });
//   //   } catch (e) {
//   //     state.value=ApiState.error;
//   //     print(e);
//   //   }
//   // }
// }
