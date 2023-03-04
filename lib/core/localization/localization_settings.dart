import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';

const String _enCode = 'en';

class LocalizationSettings {
  static Map<String, String> en = {};

  ///To define supported app locales
  static const localesList = [Locale(_enCode, 'US')];

  ///To load language files from assets folder
  static Future<void> initLangFiles() async {
    en = await _fetchFile(_enCode);
  }

  static Future<Map<String, String>> _fetchFile(String key) async {
    final String response =
        await rootBundle.loadString('assets/lang/$key.json');
    return Map.from(await json.decode(response));
  }

  static Locale get appLocale => const Locale(_enCode);
}
