import 'package:app1/bindings/general_bindings.dart';
import 'package:app1/data/services/firebase_service/firebase_options.dart';
import 'package:app1/routes/app_routes.dart';
import 'package:app1/ultis/theme/theme_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/authentication/screens/login/login.dart';
import 'ultis/local_storage/storage_utilly.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Khởi tạo storage trước
  await TLocalStorage.init('app_storage');
  // Các khởi tạo khác...
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
        // home: NavigatorMenu()
        home: const LoginScreen());
  }
}
