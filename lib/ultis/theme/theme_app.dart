import 'package:app1/ultis/theme/custom_theme/bottom_sheet_theme.dart';
import 'package:app1/ultis/theme/custom_theme/chip_theme.dart';
import 'package:app1/ultis/theme/custom_theme/appbar_theme.dart';
import 'package:app1/ultis/theme/custom_theme/elevatebutton_theme.dart';
import 'package:app1/ultis/theme/custom_theme/icons_theme.dart';
import 'package:app1/ultis/theme/custom_theme/outline_button_theme.dart';
import 'package:app1/ultis/theme/custom_theme/text_field_theme.dart';
import 'package:app1/ultis/theme/custom_theme/textbutton_theme.dart';
import 'package:app1/ultis/theme/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      appBarTheme: TAppBarTheme.lightAppbarTheme,
      brightness: Brightness.light,
      chipTheme: TChipTheme.lightChipTheme,
      scaffoldBackgroundColor: Colors.white,
      outlinedButtonTheme: TOutlineButtonTheme.lightOutlineTheme,
      textButtonTheme: TTextButtonTheme.lightTextButtonTheme,
      bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
      textTheme: TTextTheme.lightTextThem,
      iconTheme: TIconsTheme.lightIconTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedTheme,
      inputDecorationTheme: TTextFieldTheme.lightInputDecorationTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      appBarTheme: TAppBarTheme.darkAppbarTheme,
      brightness: Brightness.dark,
      chipTheme: TChipTheme.darkChipTheme,
      scaffoldBackgroundColor: Color(0xFF2C2C2C),
      outlinedButtonTheme: TOutlineButtonTheme.darkOutlineTheme,
      textButtonTheme: TTextButtonTheme.darkTextButtonTheme,
      bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
      textTheme: TTextTheme.darkTextThem,
      iconTheme: TIconsTheme.darkIconTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedTheme,
      inputDecorationTheme: TTextFieldTheme.darkInputDecorationTheme);
}
