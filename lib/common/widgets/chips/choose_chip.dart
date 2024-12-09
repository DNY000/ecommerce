import 'package:app1/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip(
      {super.key, required this.text, required this.selected, this.onSelected});

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColors = TheplerFunction.getColor(text);
    return ChoiceChip(
      label: isColors != null ? const SizedBox() : const Text(''),
      selected: selected,
      onSelected: onSelected,
      labelStyle: TextStyle(color: selected ? Colors.white10 : null),
      avatar: isColors != null
          ? TCircularContainer(
              height: 50,
              width: 50,
              radius: 120,
              background: TheplerFunction.getColor(text)!,
            )
          : null,
      shape: isColors != null ? const CircleBorder() : null,
      backgroundColor: isColors != null ? Colors.green : null,
      padding: isColors != null ? const EdgeInsets.all(0) : null,
      labelPadding: isColors != null ? const EdgeInsets.all(0) : null,
    );
  }
}
