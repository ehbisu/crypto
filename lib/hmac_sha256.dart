// lib/api/hmac_sha256.dart

import 'dart:convert';
import 'package:crypto/crypto.dart';

class HmacSha256 {
  /// Generates HMAC-SHA256 signature
  static String generateSignature(Map<String, dynamic> params, String secret) {
    // Sort the parameters alphabetically by key
    var sortedKeys = params.keys.toList()..sort();
    var queryString = sortedKeys.map((key) => '$key=${params[key]}').join('&');

    var key = utf8.encode(secret);
    var bytes = utf8.encode(queryString);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);

    return digest.toString();
  }
}
