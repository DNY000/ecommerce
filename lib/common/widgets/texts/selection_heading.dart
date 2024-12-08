import 'package:app1/ultis/constants/constants.dart';
import 'package:flutter/material.dart';

class TSelectionHeading extends StatelessWidget {
  const TSelectionHeading(
      {super.key,
      this.textcolor,
      required this.title,
      this.buttonTitle = 'Xem tất cả',
      this.showActionButton = true,
      this.onPressed});

  final Color? textcolor;
  final String title, buttonTitle;
  final bool showActionButton;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: TSizes.defaulBtwItem),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: textcolor,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (showActionButton)
            TextButton(
              onPressed: onPressed,
              child: Text(
                buttonTitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}
