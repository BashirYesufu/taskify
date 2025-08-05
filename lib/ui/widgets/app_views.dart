import 'package:flutter/material.dart';
import '../../util/ui_util/color/color_manager.dart';

class AppDivider extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  const AppDivider({
    super.key,
    this.width = double.infinity,
    this.height = 0.4,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color ?? ColorManager.of(context).textSub,
    );
  }
}

class AppRoundedView extends StatelessWidget {
  final double size;
  final Color? color;
  final Color? borderColor;
  final double? borderWidth;
  final Widget? child;
  final Function()? onTap;
  const AppRoundedView({
    super.key,
    this.size = 42,
    this.color,
    this.borderColor,
    this.borderWidth,
    this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashFactory: NoSplash.splashFactory,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: color ?? ColorManager.of(context).cardMain,
            borderRadius: BorderRadius.all(Radius.circular(size/2)),
            border: Border.all(
              color: borderColor ?? color ?? ColorManager.of(context).cardMain,
              width: borderWidth ?? 1,
            )
        ),
        child: Center(child: child),
      ),
    );
  }
}

class AppIndicator extends StatelessWidget {

  final double? width;
  final bool done;
  final String priText;
  final String secText;

  const AppIndicator({
    super.key,
    this.width,
    this.done = false,
    required this.priText,
    required this.secText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.0),
      width: width,
      height: 26,
      decoration: BoxDecoration(
        // color: done
        borderRadius: BorderRadius.all(Radius.circular(13)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            // backgroundColor: done ? ColorManager.green : ColorManager.secondaryTextDark,
            radius: 3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              priText,
              // style: done,
            ),
          ),
          Text(
            secText,
            // style: done,
          )
        ],
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final double? borderWidth;
  final Widget? child;
  final Color? borderColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool wrap;
  final BorderRadiusGeometry? borderRadius;
  final Function()? onTap;

  const AppCard({
    this.height = 100,
    this.radius = 16,
    this.width = double.infinity,
    this.child,
    this.wrap = false,
    this.borderColor,
    this.borderWidth,
    this.backgroundColor,
    this.margin,
    this.padding,
    this.borderRadius,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashFactory: NoSplash.splashFactory,
      child: Container(
        height: wrap ? null : height,
        width: wrap ? null : width,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorManager.of(context).cardMain,
          borderRadius: borderRadius ?? BorderRadius.circular(radius),
          border: Border.all(
              color: borderColor ?? ColorManager.of(context).cardMain,
              width: borderWidth ?? 0.5
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
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final bool wrap;
  final double? height;
  final double? width;
  final double borderWidth;
  final Color? color;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final Widget? child;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;

  const AppView({
    super.key,
    this.color,
    this.wrap = false,
    this.borderColor,
    this.child,
    this.onTap,
    this.padding,
    this.borderRadius,
    this.height = 50,
    this.width = 50,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Container(
        height: wrap ? null : height,
        width:  wrap ? null : width,
        padding: padding,
        decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius ?? BorderRadius.all(Radius.circular((height ?? 0) /2)),
            border: Border.all(
                color: borderColor ?? color ?? ColorManager.of(context).cardMain,
                width: borderWidth
            )
        ),
        child: Center(child: child),
      ),
    );
  }
}