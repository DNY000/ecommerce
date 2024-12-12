import 'dart:convert';

import 'package:crypto/crypto.dart';

class EncryptionService {
  static String encryptData(String data) {
    // chuyển data sang dạng bytes
    final bytes = utf8.encode(data);

    // mã hóa sha 256
    final hash = sha256.convert(bytes);

    // chuyển hash sang dạng string
    return hash.toString();
  }

  static bool verifyData(String inputData, String encryptedData) {
    final inputHash = encryptData(inputData);
    return inputHash == encryptedData;
  }
}
