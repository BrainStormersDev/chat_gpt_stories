

class MyRep{

 static Gender selectedGender =Gender.notSelect;
 static AgeSelect selectAge=AgeSelect.notSelect;


}

enum Gender {
  notSelect,
  boy,
  girl
}
enum AgeSelect {
  notSelect,
  oneToThree,
  threeToFive,
  fiveToTen,
  tenPlus,
}