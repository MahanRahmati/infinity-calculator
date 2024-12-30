import 'package:flutter/services.dart';

class Environments {
  Environments._();

  static const String website =
      'https://github.com/MahanRahmati/infinity-calculator';
  static const String issueUrl = '$website/issues';
  static const List<String> developers = <String>['Mahan Rahmati'];

  static Future<String> getLicense() async {
    try {
      return await rootBundle.loadString('LICENSE');
    } catch (e) {
      return '';
    }
  }
}
