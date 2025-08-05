import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../util/ui_util/app_text_styles.dart';
import '../../util/ui_util/color/color_manager.dart';

class AppInputField extends StatefulWidget {
  const AppInputField({
    this.controller,
    this.onChanged,
    this.onEditingComplete,
    this.readOnly = false,
    this.isCurrency = false,
    this.maxLength,
    this.onTap,
    this.hintText,
    this.onCard = false,
    this.obscureText = false,
    this.enabled = true,
    this.required = true,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscuringCharacter = '•',
    this.title = '',
    this.optionalLabel,
    this.keyboardType = TextInputType.text,
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.inputPadding,
    this.height = 48,
    this.maxLines = 1,
    this.rounded = false,
    this.textCapitalization,
    this.formatters,
    super.key
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final bool readOnly;
  final bool isCurrency;
  final bool onCard;
  final bool enabled;
  final int? maxLength;
  final String? hintText;
  final String? prefixText;
  final String obscuringCharacter;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String title;
  final String? optionalLabel;
  final TextInputType keyboardType;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? inputPadding;
  final int maxLines;
  final bool rounded;
  final bool required;
  final double height;
  final TextCapitalization? textCapitalization;
  final bool obscureText;
  final List<TextInputFormatter>? formatters;

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  FocusNode? _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title.isNotEmpty
              ? Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    widget.title,
                    style: AppTextStyles.regular(context, size: 14, weight: FontWeight.w500)
                ),
              ],
            ),
          )
              : SizedBox(),
          Container(
            height: widget.height * widget.maxLines.toDouble(),
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? ColorManager.backGround,
              shape: BoxShape.rectangle,
              border: Border.all(color: widget.borderColor ?? ColorManager.nav),
              borderRadius: BorderRadius.circular(widget.rounded ? widget.height / 2 : 12),
            ),
            padding: widget.inputPadding ?? EdgeInsets.only(top: widget.prefixIcon == null ? 0.0 : 4.0, left: widget.prefixIcon == null ? 16.0 : 0, bottom: widget.prefixIcon == null ? 6.0 : 0.0) ,
            child: TextFormField(
              enabled: widget.enabled,
              maxLines: widget.maxLines,
              controller: widget.controller,
              style: AppTextStyles.medium(context, weight: FontWeight.w500),
              onChanged: widget.onChanged,
              focusNode: _focusNode,
              onTap: (){
                widget.onTap?.call();
                _focusNode?.requestFocus();
              },
              onEditingComplete: widget.onEditingComplete,
              onTapOutside: (PointerDownEvent event){
                FocusManager.instance.primaryFocus?.unfocus();
              },
              readOnly: widget.readOnly,
              keyboardType: widget.keyboardType,
              textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
              cursorColor: ColorManager.black,
              inputFormatters: widget.formatters,
              maxLength: widget.maxLength,
              obscureText: widget.obscureText,
              obscuringCharacter: widget.obscuringCharacter,
              decoration: InputDecoration(
                counterText: '',
                hintText: widget.hintText ?? widget.title,
                prefixText: widget.prefixText,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                filled: false,
                prefixStyle: AppTextStyles.regular(context),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
