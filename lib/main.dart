import 'package:app1/bindings/general_bindings.dart';
import 'package:app1/data/services/firebase_service/firebase_options.dart'
    show DefaultFirebaseOptions;
import 'package:app1/routes/app_routes.dart' show AppRoutes;
import 'package:app1/ultis/theme/theme_app.dart' show TAppTheme;
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/authentication/screens/login/login.dart' show LoginScreen;
import 'ultis/local_storage/storage_utilly.dart' show TLocalStorage;
import 'data/services/firebase_service/firebase_notifications_service/notification_service.dart'
    show NotificationService;

// final navigatorKey = GlobalKey<NavigatorState>();
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final notificationService = NotificationService();
  notificationService.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    notificationService.showNotification(message);
  });

  await TLocalStorage.init('app_storage');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        getPages: AppRoutes.pages,
        initialBinding: GeneralBindings(),
        // navigatorKey: navigatorKey,
        // home: NavigatorMenu()
        home: const LoginScreen());
  }
}
