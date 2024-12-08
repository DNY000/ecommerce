import 'package:app1/ultis/device/device.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({
    super.key,
    required this.tabbar,
  });
  final List<Widget> tabbar;

  @override
  Widget build(BuildContext context) {
    final dark = TheplerFunction.isDarkMode(context);
    return Material(
      color: Colors.transparent,
      child: TabBar(
        tabs: tabbar,
        isScrollable: true,
        indicatorColor: Colors.blue,
        labelColor: dark ? Colors.white : Colors.black,
        unselectedLabelColor: Colors.grey,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDevice.getTabBarHeight());
}
