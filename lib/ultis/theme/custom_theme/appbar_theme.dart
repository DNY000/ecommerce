import 'package:flutter/material.dart';

class TAppBarTheme {
  TAppBarTheme._();
  static const lightAppbarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      color: Colors.black,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black, size: 20),
      titleTextStyle: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.black, size: 20));

  static const darkAppbarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black, size: 20),
      titleTextStyle: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 20));
}
