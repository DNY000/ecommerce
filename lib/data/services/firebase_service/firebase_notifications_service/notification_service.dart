import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/snackbar/snackbar.dart';
import '../../../../features/shop/screens/notification/notification.dart';

class NotificationService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // lay token
  Future<String?> getToken() async {
    final token = await firebaseMessaging.getToken();
    if (kDebugMode) {
      print('token: $token');
    }
    return token;
  }

  // cấp quyền thông báo
  void requestPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission');
      }
    } else {
      TSnackBar.showErrorSnackBar(
          title: 'Thông báo', message: 'Bạn chưa cấp quyền thông báo');
    }
  }

  // khoi tao khi o foreground
  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (kDebugMode) {
        print('notification: $notification');
        print('android: $android');
      }
      if (Platform.isIOS) {
        iosForgroundMessage();
      }
      if (Platform.isAndroid) {
        initLocalNotification(context, message);
        showNotification(message);
        iosForgroundMessage();
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        handleMessage(context, message);
      },
    );
  }

// cấu hình cho local notification
  Future<void> initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    // cấu hình cho android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    // cấu hình iso
    const iosInitSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    // Kết hợp 2 cấu hình
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: iosInitSettings,
    );
    // khời tạo flutterLocalNotificationsPlugin
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      handleMessage(context, message);
    });
  }

  //  Cấu hình thông tin hiển thị thông báo
  Future<void> showNotification(RemoteMessage message) async {
    try {
      final channelId =
          message.notification?.android?.channelId ?? 'default_channel';
      final channelName =
          message.notification?.android?.channelId ?? 'Default Channel';
      AndroidNotificationChannel channel = AndroidNotificationChannel(
        channelId,
        channelName,
        description: "Đây là channel dùng để thông báo",
        importance: Importance.high,
        showBadge: true,
        enableVibration: true,
        enableLights: true,
        playSound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      // cấu hình cho android
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
              channel.id.toString(), channel.name.toString(),
              channelDescription: 'Channel Description',
              importance: Importance.max, // độ quan trọng
              priority: Priority.max, //độ ưu tiên
              playSound: true,
              enableVibration: true,
              enableLights: true,
              sound: channel.sound,
              fullScreenIntent: true,
              category: AndroidNotificationCategory.alarm,
              visibility: NotificationVisibility.public,
              ticker: 'Ticker', // thống báo cho accessbility service
              ongoing: true // thông báo không bị dismiss

              );
      // cấu hình cho ios
      DarwinNotificationDetails darwinNotificationDetails =
          DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: 'default',
        // Thêm priority cho iOS
        interruptionLevel: InterruptionLevel.active,
      );
      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      );
      Future.delayed(
        Duration.zero,
        () {
          flutterLocalNotificationsPlugin.show(
              message.notification!.hashCode,
              message.notification!.title.toString(),
              message.notification!.body.toString(),
              notificationDetails,
              payload: message.data.toString());
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('error: $e');
      }
    }
  }

// cấu hình cho ios khi o foreground
  Future<void> iosForgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

//  xử lý các tương tác với thông báo trong các trường hợp khác nhau
  Future<void> setupInteractMessage(BuildContext context) async {
    // xử lí khi người dùng nhấn vào thông báo
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(context, message);
    });
    // xử lí khi người dùng mở app từ background  khi app đã đóng hoàn tonaf
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message != null && message.data.isNotEmpty) {
          handleMessage(context, message);
        }
      },
    );
  }

  Future<void> handleMessage(
      BuildContext context, RemoteMessage message) async {
    Get.to(() => NotificationScreen(message: message));
  }
}
