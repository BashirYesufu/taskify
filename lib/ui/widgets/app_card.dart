import 'package:flutter/material.dart';

import '../../util/ui_util/color_manager.dart';

class AppCard extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadiusGeometry? radiusGeometry;
  final double? borderRadius;
  final Widget? child;
  final Color? borderColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool wrap;
  final double borderWidth;

  const AppCard({
    this.height = 100,
    this.width = double.infinity,
    this.child,
    this.wrap = false,
    this.borderColor,
    this.borderRadius,
    this.backgroundColor,
    this.margin,
    this.padding,
    this.borderWidth = 1,
    this.radiusGeometry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: wrap ? null : height,
      width: wrap ? null : width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorManager.backGround,
        borderRadius: radiusGeometry ?? BorderRadius.circular(borderRadius ?? 12),
        border: Border.all(
          color: borderColor ?? ColorManager.grey.withValues(alpha: 0.3),
          width: borderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 30,
            offset: Offset(8, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: child,
    );
  }
}
