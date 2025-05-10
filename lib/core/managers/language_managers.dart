
import 'package:flutter/material.dart';

class LanguagesManager {
  static const Arabic = 'ar';
  static const English = 'en';

  static const appLanguages = [English, Arabic];

  static String getLanguageText(String code) {
    switch (code) {
      case Arabic:
        return 'العربية';
      case English:
        return 'English';

      default:
        return '';
    }
  }
  static const Map<String, Locale> languages = {
    'en': Locale('en'),
    'ar': Locale('ar'),

  };
}
