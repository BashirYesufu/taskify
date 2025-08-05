import 'dart:math';
import 'package:encrypt/encrypt.dart' as encrypt;
import '../data/common/variables.dart';

class Helper {

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

  static String generateSecureId({int length = 6}) {
    const String letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String numbers = '0123456789';
    const String allChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    String firstChar = letters[random.nextInt(letters.length)];
    String secondChar = numbers[random.nextInt(numbers.length)];
    List<String> remainingChars = List.generate(length, (index) => allChars[random.nextInt(allChars.length)]);
    List<String> idChars = [firstChar, secondChar, ...remainingChars]..shuffle();
    return idChars.join();
  }

}