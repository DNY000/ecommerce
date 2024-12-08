import 'package:flutter/material.dart';

class TShadowStyle {
  static final verticalProductShadow = BoxShadow(
      blurRadius: 50,
      spreadRadius: 7,
      color: Colors.grey.withOpacity(0.1),
      offset: const Offset(0, 2));
  static final horizantalProductShadow = BoxShadow(
      blurRadius: 50,
      spreadRadius: 7,
      color: Colors.grey.withOpacity(0.1),
      offset: const Offset(0, 2));
}
