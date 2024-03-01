import 'dart:convert';
import 'dart:io';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../utils/MyRepo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'view/Pages/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseDynamicLinks.instance;
  await GetStorage.init();
  messageHandler();
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
  messaging.getToken().then((token) {
    MyRepo.deviceToken.value = token!;
    print("===D_Token:${MyRepo.deviceToken.value}==");
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
    print("====event: ${event}=====");
    if(Platform.isAndroid){
      await _showNotification(event);
      // await showNotificationBG(event);
    }

  });
}

Future<void> _showNotification(var data) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
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
  });
}
Future onSelectNotification(var payload) async {
  if (payload != null) {
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Story Telling',
      scrollBehavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
      home: const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home:SplashPage(),
      ),
    );
  }
}


