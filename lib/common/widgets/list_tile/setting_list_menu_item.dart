import 'package:flutter/material.dart';

class SettingListMenuItem extends StatelessWidget {
  const SettingListMenuItem(
      {super.key,
      required this.title,
      required this.subtile,
      required this.icon,
      this.tranling,
      this.onTap});

  final String title, subtile;
  final IconData icon;
  final Widget? tranling;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
        color: Colors.black12,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        subtile,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: tranling,
      onTap: onTap,
    );
  }
}
