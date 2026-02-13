import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:i_cash/common/constant/config.dart';

String hashPassword(String password) {

  final keyBytes = utf8.encode(Config.secretKey);
  final messageBytes = utf8.encode(password);

  final hmacSha256 = Hmac(sha256, keyBytes);
  final digest = hmacSha256.convert(messageBytes);

  return digest.toString();
}
