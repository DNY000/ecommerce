import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TAnimationLoader extends StatelessWidget {
  const TAnimationLoader(
      {super.key,
      required this.text,
      required this.animation,
      this.showAnimation = false,
      this.actionText,
      this.onActionPressed});

  final String text;
  final String animation;
  final bool showAnimation;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(animation,
            width: MediaQuery.of(context).size.width * 0.6, fit: BoxFit.cover),
        const SizedBox(height: 20),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: Theme.of(context).colorScheme.onSurface),
        ),
        const SizedBox(height: 20),
        showAnimation
            ? SizedBox(
                width: 250,
                child: OutlinedButton(
                    onPressed: onActionPressed, child: Text(actionText ?? '')))
            : const SizedBox(),
      ],
    );
  }
}
