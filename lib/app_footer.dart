import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nineboot/tools/locale_provider.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

class AppFooter extends StatefulWidget {
  const AppFooter({Key? key}) : super(key: key);

  @override
  State<AppFooter> createState() => _AppFooterState();
}

class _AppFooterState extends State<AppFooter> {
  late String _locale;
  final Map _languages = {'en': 'English', 'zh_CN': '简体中文'};

  @override
  void initState() {
    super.initState();
    Locale currentLocal = Localizations.localeOf(context);
    String tmpLocale = currentLocal.languageCode;
    if (currentLocal.countryCode != null) {
      tmpLocale += ('_' + currentLocal.countryCode.toString());
      setState(() {
        _locale = tmpLocale;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: DropdownButton<String>(
          value: _locale,
          onChanged: (newValue) {
            log('selected : ' + newValue!);
            var codes = newValue.split('_');
            Locale newLocale;
            if (codes.length == 1) {
              newLocale = Locale(codes[0]);
            } else {
              newLocale = Locale(codes[0], codes[1]);
            }

            final provider =
            Provider.of<LocaleProvider>(context, listen: false);
            provider.setLocale(newLocale);
            setState(() {
              _locale = newValue;
            });
            log(_locale);
          },
          items: _languages.entries
              .map((e) =>
                  DropdownMenuItem<String>(value: e.key, child: Text(e.value)))
              .toList(),
        )),
      ],
    );
  }
}
