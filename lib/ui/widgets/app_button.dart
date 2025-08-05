import 'package:flutter/material.dart';
import '../../util/ui_util/color/color_manager.dart';

class AppButton extends StatelessWidget {
  const AppButton({this.onTap, required this.title, this.decoration, this.textColor, super.key});
  final Function()? onTap;
  final String title;
  final Decoration? decoration;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: decoration ?? BoxDecoration(
          color: ColorManager.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Text(title, style: TextStyle(color:textColor ?? Colors.white, fontWeight: FontWeight.w700),)),
      ),
    );
  }
}
