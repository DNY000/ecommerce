import 'package:flutter/material.dart';

class TCustomCurveEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    final fisrtCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(
        fisrtCurve.dx, fisrtCurve.dy, lastCurve.dx, lastCurve.dy);
    final secondFisrtCurve = Offset(0, size.height - 20);
    final secondlastCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondFisrtCurve.dx, secondFisrtCurve.dy,
        secondlastCurve.dx, secondlastCurve.dy);
    final thirdFisrtCurve = Offset(size.width, size.height - 20);
    final thirdlastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdFisrtCurve.dx, thirdFisrtCurve.dy,
        thirdlastCurve.dx, thirdlastCurve.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw UnimplementedError();
  }
}
