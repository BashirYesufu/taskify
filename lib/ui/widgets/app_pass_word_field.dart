import 'package:flutter/material.dart';
import 'package:taskify/util/ui_util/app_text_styles.dart';
import 'package:taskify/util/ui_util/color/color_manager.dart';
import 'app_input_field.dart';

class AppPasswordField extends AppInputField {
  const AppPasswordField({this.onTap, super.controller, super.title, super.maxLength, super.hintText, super.onChanged, super.key});
  final Function()? onTap;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: AppInputField(
        title: widget.title,
        hintText: widget.hintText,
        controller: widget.controller,
        // prefixIcon: SvgPicture.asset(ImageManager.of(context).lock, fit: BoxFit.scaleDown,),
        onChanged: widget.onChanged,
        enabled: true,
        obscureText: isHidden,
        maxLength: widget.maxLength,
        obscuringCharacter: '•',
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  isHidden = !isHidden;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(isHidden ? 'Show' : 'Hide', style: AppTextStyles.regular(context, color: ColorManager.of(context).mainBackgroundInverted),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}