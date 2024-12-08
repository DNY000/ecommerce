import 'package:app1/common/widgets/custom_shapes/curve_edges/curve_edges.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TCurveEdgesWidget extends StatelessWidget {
  TCurveEdgesWidget({super.key, required this.child});
  Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: TCustomCurveEdges(), child: child);
  }
}
