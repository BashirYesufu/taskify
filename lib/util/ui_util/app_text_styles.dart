import 'package:flutter/material.dart';

class AppTextStyles {

  static TextStyle? black({FontWeight? weight, double? size, Color? color}) => TextStyle(fontSize: size ?? 14, color: color ?? Colors.black, fontWeight: weight ?? FontWeight.w400);
  static TextStyle green({FontWeight? weight, double? size}) => TextStyle(fontSize: size ?? 14, color: Colors.green, fontWeight: weight ?? FontWeight.w400);
  static TextStyle orange({FontWeight? weight, double? size}) => TextStyle(fontSize: size ?? 14, color: Colors.orange, fontWeight: weight ?? FontWeight.w400);
  static TextStyle blue({FontWeight? weight, double? size}) => TextStyle(fontSize: size ?? 14, color: Colors.blue, fontWeight: weight ?? FontWeight.w400);
  static TextStyle grey({FontWeight? weight, double? size}) => TextStyle(fontSize: size ?? 14, color: Colors.grey, fontWeight: weight ?? FontWeight.w400);
  static TextStyle red({FontWeight? weight, double? size}) => TextStyle(fontSize: size ?? 14, color: Colors.red, fontWeight: weight ?? FontWeight.w400);
}