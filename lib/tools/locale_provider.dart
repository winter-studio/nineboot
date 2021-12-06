import 'package:flutter/material.dart';
import 'package:nineboot/generated/l10n.dart';

import 'locale_utils.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  LocaleProvider(String? locale) {
    if (locale != null) {
      _locale = LocaleUtils.getLocale(locale);
    }
  }

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    S.load(_locale!);
    notifyListeners();
  }
}
