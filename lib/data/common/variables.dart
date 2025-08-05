import 'package:flutter_dotenv/flutter_dotenv.dart';

class Variables {

  static String get encryptionKey {
    return dotenv.env['ENCRYPTION_KEY'] ?? '';
  }

}