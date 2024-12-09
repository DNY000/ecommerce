import 'package:app1/ultis/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TProfileMenu extends StatelessWidget {
  const TProfileMenu(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.value,
      this.icon = FontAwesomeIcons.penToSquare});

  final VoidCallback onPressed;
  final String title, value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.borderRaidusM),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(color: Colors.black38),
                )),
            Expanded(
                flex: 5,
                child: Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: Colors.black),
                )),
            Expanded(
                child: Icon(
              icon,
              size: 18,
            ))
          ],
        ),
      ),
    );
  }
}
