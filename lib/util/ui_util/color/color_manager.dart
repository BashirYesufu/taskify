import 'package:flutter/material.dart';
import 'package:taskify/util/ui_util/color/repo/color_dark.dart';
import 'package:taskify/util/ui_util/color/repo/color_light.dart';
import 'package:taskify/util/ui_util/color/repo/themed_color.dart';

class ColorManager {

  static ThemedColor of(BuildContext context){
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? ColorDark() : ColorLight();
  }

  static Color nav = Color(0xFFE5E7E6);
  static Color black = Color(0xFF000000);
  static Color deepGreen = Color(0xFF056033);
  static Color green = Color(0xFF00AD57);
  static Color border = Color(0xFFCECECE);
  static Color backGround = Color(0xFFFFFFFF);
  static Color blue = Color(0xFF89AFFF);
  static Color grey = Color(0xFF616161);
  static Color orange = Color(0xFFD9694D);

}