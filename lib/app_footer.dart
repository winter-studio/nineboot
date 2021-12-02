import 'package:flutter/material.dart';

import 'generated/l10n.dart';

class AppFooter extends StatefulWidget {
  const AppFooter({Key? key}) : super(key: key);

  @override
  State<AppFooter> createState() => _AppFooterState();
}

class _AppFooterState extends State<AppFooter> {
  // Locale locale = Locale(Intl.getCurrentLocale());
  late Locale locale;
  List<Locale> locales = S.delegate.supportedLocales;

  @override
  Widget build(BuildContext context) {
    locale = Localizations.localeOf(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 12),
          child: const Icon(
            Icons.translate,
            size: 24,
          ),
        ),
        DropdownButtonHideUnderline(
            child: DropdownButton<Locale>(
          value: locale,
          onChanged: (Locale? newValue) {
            if (newValue != null) {
              S.load(newValue);
              setState(() {
                locale = newValue;
              });
            }
          },
          items: locales.map<DropdownMenuItem<Locale>>((Locale value) {
            return DropdownMenuItem<Locale>(
              value: value,
              child: Text(value.languageCode),
            );
          }).toList(),
        )),
      ],
    );
  }
}
