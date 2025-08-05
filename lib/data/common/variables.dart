import 'package:flutter_dotenv/flutter_dotenv.dart';

class Variables {

  static String get encryptionKey => dotenv.env['ENCRYPTION_KEY'] ?? '';
  static String get geminiKey => dotenv.env['GEMINI_KEY'] ?? '';

}