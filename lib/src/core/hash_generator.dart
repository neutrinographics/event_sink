import 'dart:convert';
import 'package:crypto/crypto.dart';

abstract class HashGenerator {
  /// Generate MD5 hash from the given [data].
  String generateHash(String data);
}

class HashGeneratorImpl implements HashGenerator {
  const HashGeneratorImpl();

  @override
  String generateHash(String data) {
    return md5.convert(utf8.encode(data)).toString();
  }
}
