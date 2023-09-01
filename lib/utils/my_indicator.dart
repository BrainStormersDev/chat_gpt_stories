import 'package:flutter/material.dart';


import 'app_color.dart';

Widget myIndicator() {
  return const SizedBox(
    width: double.infinity,
    height: 40,
    child: Center(
      child: CircularProgressIndicator( color: AppColors.kPrimary,),
    ),
  );
}
Widget detailText({required String title,required String description}){
  if(description.toString() =="null"){

    description='';
    return Container();
  }else{
    return Container(
      margin: const EdgeInsets.symmetric(vertical:3 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title: ",style: TextStyle(fontWeight: FontWeight.bold),),
          Expanded(child: Text(description,)),
        ],
      ),
    );
  }

}
