import 'package:flutter/material.dart';

class TChipTheme {
  TChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    checkmarkColor: Colors.white,
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    disabledColor: Colors.grey,
    backgroundColor: Colors.lightBlue.shade100,
    // secondarySelectedColor: Colors.lightBlue,
    // shadowColor: Colors.black.withOpacity(0.2),
    elevation: 4.0,
    pressElevation: 8.0,
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.circular(8),
    // ),
  );
  static ChipThemeData darkChipTheme = ChipThemeData(
    checkmarkColor: Colors.white,
    // dấu tích khi được chọn
    labelStyle: const TextStyle(color: Colors.white),
    selectedColor: Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    disabledColor: Colors.grey,
    backgroundColor: Colors.lightBlue.shade100,
    secondarySelectedColor: Colors.lightBlue,
    shadowColor: Colors.black.withOpacity(0.2),
    elevation: 4.0,
    pressElevation: 8.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
