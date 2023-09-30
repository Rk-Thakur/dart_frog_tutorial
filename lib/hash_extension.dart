// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:crypto/crypto.dart';

//add hash functionality to OUR String id
extension HashStringExtension on String {
  //Returns the SHA256 has of this string
  String get hashValue {
    return sha256.convert(utf8.encode(this)).toString();
  }
}
