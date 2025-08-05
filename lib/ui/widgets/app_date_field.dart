import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../util/route/app_router.dart';
import '../../util/ui_util/app_text_styles.dart';
import '../../util/ui_util/color/color_manager.dart';
import 'app_input_field.dart';

class AppDateField extends AppInputField {
  const AppDateField({super.controller, super.title, super.hintText, super.onChanged, super.borderColor, this.onDateChanged, this.initialDate, this.canTap = true, this.pickTime = true, this.initialTime, this.pickPast = false, super.key});
  final Function(DateTime)? onDateChanged;
  final bool canTap;
  final bool pickPast;
  final bool pickTime;
  final DateTime? initialDate;
  final TimeOfDay? initialTime;

  @override
  State<AppDateField> createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField> {
  String get dateFormat => widget.pickTime ? "EE, d MMMM, y h:mma" : 'dd MMM, yyyy';
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () async {
        if(widget.canTap == false) {
          return;
        }
        if (Platform.isIOS) {
          setState(() {
            widget.controller?.text = DateFormat(dateFormat).format(widget.initialDate ?? DateTime.now());
            widget.onDateChanged?.call(widget.initialDate ?? DateTime.now());
            widget.onChanged?.call(DateFormat(dateFormat).format(widget.initialDate ?? DateTime.now()));
          });
          await showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 300.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 40,
                      color: ColorManager.of(context).cardMain,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      // margin: const EdgeInsets.symmetric(horizontal: 30.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: ()=> AppRouter.goBack(context),
                            child: DefaultTextStyle(
                              style: AppTextStyles.medium(context, size: 14, weight: FontWeight.w600),
                              child: Text(
                                'Confirm',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: CupertinoDatePicker(
                        mode: widget.pickTime ? CupertinoDatePickerMode.dateAndTime : CupertinoDatePickerMode.date,
                        initialDateTime: widget.initialDate,
                        minimumDate: widget.pickPast ? null : widget.initialDate ?? DateTime.now(),
                        maximumDate: null,
                        backgroundColor: ColorManager.of(context).cardMain,
                        onDateTimeChanged: (pickedDate){
                          setState(() {
                            widget.controller?.text = DateFormat(dateFormat).format(pickedDate);
                            widget.onDateChanged?.call(pickedDate);
                            widget.onChanged?.call(DateFormat(dateFormat).format(pickedDate));
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        else {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: widget.initialDate ?? DateTime.now(),
              firstDate: widget.pickPast ? DateTime(1900) : (widget.initialDate ?? DateTime.now()),
              lastDate: DateTime.now().add(Duration(days: 60)),
              initialDatePickerMode: DatePickerMode.day
          );
          if (pickedDate != null) {
            showTime(date: pickedDate, onTimeChanged: (finalDate){
              setState(() {
                widget.controller?.text = DateFormat(dateFormat).format(finalDate);
                widget.onDateChanged?.call(pickedDate);
                widget.onChanged?.call(DateFormat(dateFormat).format(finalDate));
              });
            });
          }
        }
      },
      child: AppInputField(
        title: widget.title,
        hintText: widget.hintText,
        borderColor: widget.backgroundColor,
        controller: widget.controller,
        onChanged: widget.onChanged,
        enabled: false,
      ),
    );
  }

  void showTime({required DateTime date, Function(DateTime)? onTimeChanged}) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context, initialTime: widget.initialTime ?? TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        final DateTime dateTime = DateTime(
          date.year,
          date.month,
          date.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        final time = DateTime(dateTime.year, dateTime.month, dateTime.day, selectedTime.hour, selectedTime.minute);
        onTimeChanged?.call(time);
      });
    }
  }

}
