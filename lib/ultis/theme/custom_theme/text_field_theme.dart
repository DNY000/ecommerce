import 'package:flutter/material.dart';

class TTextFieldTheme {
  TTextFieldTheme._();
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle().copyWith(fontSize: 12, color: Colors.black),
    hintStyle: const TextStyle().copyWith(fontSize: 12, color: Colors.black38),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: Colors.black12.withOpacity(0.4)),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 0.5, color: Colors.grey)),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 0.5, color: Colors.grey)),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 0.5, color: Colors.grey)),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 0.5, color: Colors.redAccent)),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 0.5, color: Colors.grey)),
  );
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle().copyWith(fontSize: 12, color: Colors.white),
    hintStyle: const TextStyle().copyWith(fontSize: 12, color: Colors.white30),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: Colors.black12.withOpacity(0.4)),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(width: 0.5, color: Colors.grey.shade300)),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 0.5, color: Colors.grey)),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 0.5, color: Colors.grey)),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 0.5, color: Colors.redAccent)),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 0.5, color: Colors.grey)),
  );
}
