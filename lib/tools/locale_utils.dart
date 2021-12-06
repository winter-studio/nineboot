import 'dart:ui';

class LocaleUtils {
  static Locale getLocale(String locale) {
    var codes = locale.split('_');
    Locale newLocale;
    if (codes.length == 1) {
      newLocale = Locale.fromSubtags(languageCode: codes[0]);
    } else {
      newLocale =
          Locale.fromSubtags(languageCode: codes[0], countryCode: codes[1]);
    }
    return newLocale;
  }
}
