import 'package:flutter/material.dart';
import 'app_color.dart';
import 'dart:async';
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


class LoadingDots extends StatefulWidget {
  @override
  _LoadingDotsState createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots> {
  late Timer _timer;
  int _dotCount = 1;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _dotCount = (_dotCount + 1) % 4; // Change the number of dots as needed
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Story is creating' + '.' * _dotCount,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: "BalooBhai",color: AppColors.kPrimary,), // Adjust font size as needed
    );
  }
}

