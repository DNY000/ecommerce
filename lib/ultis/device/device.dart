import 'package:flutter/material.dart';

class TDevice {
  TDevice._();
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static double getTabBarHeight() {
    return kToolbarHeight;
  }
}
