import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:app1/ultis/constants/tcolor.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:app1/ultis/device/device.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon = FontAwesomeIcons.magnifyingGlass,
    this.showBackground = true,
    this.showBoder = true,
  });
  final String text;
  final IconData icon;
  final bool showBackground, showBoder;

  @override
  Widget build(BuildContext context) {
    final dark = TheplerFunction.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.borderRaidusl),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: TDevice.getScreenWidth(context),
          padding: const EdgeInsets.all(TSizes.l),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSizes.buttonRadius),
              border: showBoder ? Border.all(color: Colors.white) : null,
              color: showBackground
                  ? (dark ? Colors.black38 : TColor.white)
                  : Colors.transparent),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black.withOpacity(0.4),
              ),
              const SizedBox(
                width: TSizes.defaulBtwItem,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
