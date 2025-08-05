import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import '../data/common/variables.dart';

class Helper {

  static Future<void> showPlatformDatePicker(
      BuildContext context, {
        required Function(DateTime date) onDateSelected,
        bool pickTime = false,
        bool canPickPast = false,
        bool canPickFuture = false,
        DateTime? initialDate,
      }) async {
      DateTime? selectedDate;
      if (pickTime) {
        selectedDate = await showOmniDateTimePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: initialDate ?? (canPickPast ? DateTime(1900) : DateTime.now()),
          lastDate: null,
          is24HourMode: false,
          isShowSeconds: false,
          minutesInterval: 1,
          secondsInterval: 1,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          constraints: BoxConstraints(
            maxWidth: 350,
            maxHeight: 650,
          ),
          transitionBuilder: (context, anim1, anim2, child) {
            return FadeTransition(
              opacity: anim1.drive(
                Tween(
                  begin: 0,
                  end: 1,
                ),
              ),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 200),
          barrierDismissible: true,
        );
      } else {
        selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: canPickPast ? DateTime(1900) : DateTime.now(),
            lastDate: canPickFuture ? DateTime(3000) : DateTime.now(),
            builder: (context, child){
              return DatePickerDialog(
                firstDate: initialDate ?? (canPickPast ? DateTime(1900) : DateTime.now()),
                lastDate: canPickFuture ? DateTime(3000) : DateTime.now(),
                initialDate: initialDate ?? DateTime.now(),
              );
            }
        );
      }

      if (selectedDate != null) {
        onDateSelected.call(selectedDate);
      }
  }

  static String encryptText(String text){
    final key = encrypt.Key.fromUtf8(Variables.encryptionKey.padRight(32).substring(0, 32));
    final iv = encrypt.IV.fromUtf8(Variables.encryptionKey.padRight(16).substring(0, 16));
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  static String decryptText(String text){
    final key = encrypt.Key.fromUtf8(Variables.encryptionKey.padRight(32).substring(0, 32));
    final iv = encrypt.IV.fromUtf8(Variables.encryptionKey.padRight(16).substring(0, 16));
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypt.Encrypted.fromBase64(text);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }

}