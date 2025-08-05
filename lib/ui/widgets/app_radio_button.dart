import 'package:flutter/material.dart';
import '../../util/ui_util/app_text_styles.dart';
import '../../util/ui_util/color/color_manager.dart';
import 'app_views.dart';

class AppRadioButton extends StatelessWidget {
  const AppRadioButton({
    super.key,
    this.active = false,
    this.title,
    this.selectedColor,
    this.onChanged,
  });

  final bool active;
  final String? title;
  final Color? selectedColor;
  final Function(bool value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onChanged?.call(true);
      },
      child: Row(
        children: [
          AppRoundedView(
            size: 22,
            color: active
                ? selectedColor ?? ColorManager.of(context).mainBackgroundInverted
                : ColorManager.of(context).textSub,
            child: AppRoundedView(
              size: 20,
              borderColor: ColorManager.of(context).mainBackground,
              child: AppRoundedView(
                size: 15,
                color: active
                    ? selectedColor ?? ColorManager.green
                    : Colors.transparent,
              ),
            ),
          ),
          title != null ? Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(title ?? '', style: AppTextStyles.regular(context, size: 16),),
          ) : SizedBox()
        ],
      ),
    );
  }
}
