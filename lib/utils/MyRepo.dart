

import 'package:get/get_rx/src/rx_types/rx_types.dart';

class MyRepo{


  static RxString deviceToken=''.obs;
  static RxInt count=0.obs;
 static Gender selectedGender =Gender.notSelect;
 static AgeSelect selectAge=AgeSelect.notSelect;

  static RxString kApiToken="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".obs;


}

const String kAge="AgeParam";
const String kGender="kGender";
const String kTokenStorage="token";

const String kBaseUrl="http://story-telling.eduverse.uk/api/v1/";





enum Gender {
  notSelect,
  boy,
  girl
}
enum AgeSelect {
  notSelect,
  two,
  four,
  seven,
  thirteen,
}