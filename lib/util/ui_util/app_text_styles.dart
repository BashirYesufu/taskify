import 'package:flutter/material.dart';
import '../font.dart';
import 'color/color_manager.dart';

class AppTextStyles {

  static TextStyle regular(BuildContext context, {bool secondary = false, Color? color, TextDecoration? decoration, double? size, FontWeight? weight}) {
    return TextStyle(
        decoration: decoration,
        decorationColor: color ?? (secondary ? ColorManager.of(context).textSub : ColorManager.of(context).textMain),
        color: color ?? (secondary ? ColorManager.of(context).textSub : ColorManager.of(context).textMain),
        fontSize: size ?? 14,
        fontWeight: weight ?? FontWeight.w400,
        fontFamily: AppFonts.avenir
    );
  }

  static TextStyle medium(BuildContext context, {bool secondary = false, Color? color, double? size, FontWeight? weight}) {
    return TextStyle(
        color: color ?? (secondary ? ColorManager.of(context).textSub : ColorManager.of(context).textMain),
        fontSize: size ?? 14,
        fontWeight: weight ?? FontWeight.w500,
        fontFamily: AppFonts.avenir
    );
  }

  static TextStyle bold(BuildContext context, {bool secondary = false, Color? color, double? size, FontWeight? weight}) {
    return TextStyle(
        color: color ?? (secondary ? ColorManager.of(context).textSub : ColorManager.of(context).textMain),
        fontSize: size ?? 14,
        fontWeight: weight ?? FontWeight.w600,
        fontFamily: AppFonts.avenir
    );
  }

  static TextStyle extraBold(BuildContext context, {bool secondary = false, Color? color, double? size, FontWeight? weight}) {
    return TextStyle(
        color: color ?? (secondary ? ColorManager.of(context).textSub : ColorManager.of(context).textMain),
        fontSize: size ?? 14,
        fontWeight: weight ?? FontWeight.w700,
        fontFamily: AppFonts.avenir
    );
  }

  static TextStyle superBold(BuildContext context, {bool secondary = false, Color? color, double? size, FontWeight? weight}) {
    return TextStyle(
        color: color ?? (secondary ? ColorManager.of(context).textSub : ColorManager.of(context).textMain),
        fontSize: size ?? 14,
        fontWeight: weight ?? FontWeight.w800,
        fontFamily: AppFonts.avenir
    );
  }

}