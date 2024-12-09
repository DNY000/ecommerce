import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';

class TRatingLinearProgressIndicator extends StatelessWidget {
  const TRatingLinearProgressIndicator({
    super.key,
    required this.value,
    required this.text,
  });
  final double value;
  final String text;
  @override
  Widget build(BuildContext context) {
    final dark = TheplerFunction.isDarkMode(context);
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: dark ? Colors.white : Colors.black),
            )),
        Expanded(
            flex: 11,
            child: LinearProgressIndicator(
              minHeight: 11,
              valueColor: const AlwaysStoppedAnimation(Colors.blueAccent),
              value: value,
              borderRadius: BorderRadius.circular(7),
              backgroundColor: Colors.grey,
            ))
      ],
    );
  }
}
