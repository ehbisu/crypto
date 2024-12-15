// lib/utils/hash_utils.dart

import 'dart:convert';
import 'package:crypto/crypto.dart';

class HashUtils {
  /// Hashes a plain text password using SHA-256
  static String hashPassword(String password) {
    var bytes = utf8.encode(password); // Convert password to bytes
    var digest = sha256.convert(bytes); // Perform SHA-256 hashing
    return digest.toString(); // Convert digest to hexadecimal string
  }
}
