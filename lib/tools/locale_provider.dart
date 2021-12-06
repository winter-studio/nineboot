import 'package:flutter/material.dart';
import 'package:nineboot/generated/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    S.load(_locale!);
    notifyListeners();
  }
}
