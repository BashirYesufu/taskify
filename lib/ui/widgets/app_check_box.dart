import 'package:flutter/material.dart';
import '../../util/ui_util/color/color_manager.dart';

class AppCheckBox extends StatefulWidget {
  const AppCheckBox({this.onChanged, super.key});
  final Function(bool)? onChanged;

  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          isActive = !isActive;
        });
        widget.onChanged?.call(isActive);
      },
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: isActive ? ColorManager.green : ColorManager.backGround,
          border: Border.all(
            color: isActive ? ColorManager.green : ColorManager.border,
            width: 0.8,
          )
        ),
        child: isActive ? Center(child: Icon(Icons.check, color: Colors.white, size: 16,)) : SizedBox(),
      ),
    );
  }
}
