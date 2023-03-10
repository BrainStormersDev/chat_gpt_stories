import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'view/Pages/splash_page.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  PackageInfo.fromPlatform();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Story Telling',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: GetMaterialApp(

          home: SplashPage()),
    );
  }
}

