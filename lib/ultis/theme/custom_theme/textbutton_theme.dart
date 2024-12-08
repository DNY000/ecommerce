import 'package:flutter/material.dart';

class TTextButtonTheme {
  TTextButtonTheme._();

  static TextButtonThemeData lightTextButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.blue), // Màu nền của nút
      foregroundColor: WidgetStateProperty.all(Colors.white), // Màu chữ của nút
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
          horizontal: 16, vertical: 12)), // Đệm cho nút
      shape: WidgetStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Bo tròn các góc nút
      )),
      elevation: WidgetStateProperty.all(4), // Độ cao bóng của nút
    ),
  );
  static TextButtonThemeData darkTextButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          WidgetStateProperty.all(Colors.grey.shade400), // Màu nền của nút
      foregroundColor: WidgetStateProperty.all(Colors.white), // Màu chữ của nút
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
          horizontal: 16, vertical: 12)), // Đệm cho nút
      shape: WidgetStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Bo tròn các góc nút
      )),
      elevation: WidgetStateProperty.all(4), // Độ cao bóng của nút
    ),
  );
}
