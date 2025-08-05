import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../util/ui_util/app_text_styles.dart';
import '../../util/ui_util/color_manager.dart';

class AppPickerField<T> extends StatefulWidget{

  const AppPickerField({
    this.onTap,
    this.title,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.asyncItems,
    this.itemAsString,
    this.onChanged,
    this.controller,
    this.items = const [],
    super.key,
  });

  final Function()? onTap;
  final String? title;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Future<List<T>> Function(String)? asyncItems;
  final List<T> items;
  final TextEditingController? controller;
  final String Function(T)? itemAsString;
  final void Function(T?)? onChanged;

  @override
  State<AppPickerField> createState() => _AppPickerFieldState();
}

class _AppPickerFieldState<T> extends State<AppPickerField<T>> {

  @override
  Widget build(BuildContext context) {

    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: ColorManager.grey,
        width: 0,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.title != null && widget.title?.isEmpty == false ? Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
              widget.title!,
              style: AppTextStyles.black(weight: FontWeight.w500)
          ),
        ) :  SizedBox(),
        SizedBox(
          height: 44,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: DropdownSearch<T>(
              asyncItems: widget.asyncItems,
              items: widget.items,
              popupProps: PopupProps.menu(
                  listViewProps: ListViewProps(
            
                  ),
                  menuProps: MenuProps(
                      borderRadius: BorderRadius.circular(4),
                      backgroundColor: ColorManager.backGround,
                  ),
                  showSelectedItems: false,
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    controller: widget.controller,
                    style: AppTextStyles.black(),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Icon(Icons.search),
                        labelText: "Search",
                        labelStyle: AppTextStyles.black()
                    ),
                  )
              ),
              itemAsString: widget.itemAsString,
              onChanged: widget.onChanged,
              dropdownButtonProps: DropdownButtonProps(
                  icon: widget.suffixIcon ?? Icon(Icons.keyboard_arrow_down_rounded, color: ColorManager.grey,)
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: widget.hintText,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintStyle: AppTextStyles.grey(),
                  fillColor: ColorManager.backGround,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                  labelStyle: AppTextStyles.black(),
                  helperStyle: AppTextStyles.black(),
                  suffixIconColor: ColorManager.grey,
                  prefixIcon: widget.prefixIcon,
                  border: border,
                  errorBorder: border,
                  enabledBorder: border,
                  disabledBorder: border,
                  focusedErrorBorder: border,
                  focusedBorder: border,
                ),
                baseStyle:  AppTextStyles.black(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
