import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

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

  static Future<String> getVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
