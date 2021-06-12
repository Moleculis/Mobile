import 'dart:convert';

import 'package:crypto/crypto.dart';

class HashUtils {
  static String countHash(String text) {
    return md5.convert(utf8.encode(text)).toString();
  }
}
