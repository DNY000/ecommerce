import 'package:app1/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:app1/common/widgets/custom_shapes/curve_edges/curve_edges_widget.dart';
import 'package:app1/ultis/constants/tcolor.dart';
import 'package:flutter/material.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer(
      {super.key, required this.child, this.height = 360});
  final Widget child;
  final double height;
  @override
  Widget build(BuildContext context) {
    return TCurveEdgesWidget(
      child: Container(
        padding: const EdgeInsets.all(0),
        color: Colors.blue[300],
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: TCircularContainer(
                  background: TColor.textWhite.withOpacity(0.1),
                  height: 350,
                  width: 400,
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: TCircularContainer(
                  background: TColor.textWhite.withOpacity(0.1),
                  height: 400,
                  width: 400,
                ),
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}
