import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'view/Pages/splash_page.dart';

// Future<void> backgroundHandler(RemoteMessage message) async {
//   print(message.data.toString());
//   print(message.notification!.title);
// }

String? stDeviceToken;
RxInt count =0.obs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await _localNotification();
  runApp(const MyApp());
}


Future<void> messageHandler() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  messaging.subscribeToTopic('all');
  messaging.getToken().then((deviceToken) {
    stDeviceToken = deviceToken;
    print("D_Token:$stDeviceToken==");
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
    print("====event: ${event}=====");
    // NotiData notiData =NotiData.fromJson(jsonDecode(event));
    // print("====event:${notiData.title},=====");// main heading
    // print("====event:${notiData.body},=====");//sub heeading
    // print("====event:${notiData.date},=====");//boday



    count.value++;

    if(Platform.isAndroid){
      await _showNotification(event);
      // await showNotificationBG(event);
    }

  });
}

Future<void> _showNotification(var data) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: onSelectNotification);

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails('your channel id', 'your channel name',
      importance: Importance.max,
      priority: Priority.high,

      ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: DarwinNotificationDetails(
      sound: 'default.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );

  // _type = data['type'];
  String payload = json.encode(data.countryModelData);
  await flutterLocalNotificationsPlugin.show(0, "data.notification!.title!", "data.notification!.body", platformChannelSpecifics, payload: payload);
  await flutterLocalNotificationsPlugin.show(0, data.notification!.title, data.notification!.body, platformChannelSpecifics, payload: payload);

  print("===========body:${data.toString()}====${data['title'].toString()}=========");
}

_localNotification() {
  var initializationSettingsAndroid =
  const AndroidInitializationSettings('@mipmap/ic_launcher');
  //for IOS
  final DarwinInitializationSettings initializationSettingsIOS =
  DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  _flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification);
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    print("========event.data:${event.notification}=========");

    // Get.to(DashBoard());
    // print("========event.data:${jsonDecode(event.data.toString())}=========");
    // print("========event.data:${event.data}=========");
    // showNotificationBG(event);
    _showNotification(event);
  });
}


Future onSelectNotification(var payload) async {
  if (payload != null) {
    print("===payload:$payload===");
    // NotiData notiData =NotiData.fromJson(jsonDecode(payload));
    // _type.value =notiData.title;
    // print("====_type.value:${_type.value}=======");
    // print("====_type.value:${notiData.title}=======");
    // gotoRoute(notiData);

  }
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
