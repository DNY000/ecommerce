import 'package:flutter/material.dart';

class TCircularContainer extends StatelessWidget {
  const TCircularContainer(
      {super.key,
      this.height,
      this.width,
      this.radius = 400,
      this.padding = 0,
      this.margin = 0,
      this.isShowBorder = false,
      this.colorBorder = Colors.grey,
      this.border,
      this.child,
      this.background});

  final double? height;
  final double? width;
  final double radius;
  final double padding;
  final Widget? child;
  final Color? background;
  final double margin;
  final BoxBorder? border;
  final bool isShowBorder;
  final Color colorBorder;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: padding),
      decoration: BoxDecoration(
          border: isShowBorder
              ? Border.all(color: colorBorder.withOpacity(0.4))
              : null,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: background),
      child: child,
    );
  }
}
