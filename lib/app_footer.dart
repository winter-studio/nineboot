import 'dart:developer';

import 'package:flutter/material.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    Locale currentLocal = Localizations.localeOf(context);
    String tmpLocale = currentLocal.languageCode;
    if (currentLocal.countryCode != null) {
      tmpLocale += ('_' + currentLocal.countryCode.toString());
      setState(() {
        log('init locale : ' + tmpLocale);
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
            var codes = newValue!.split('_');
            Locale newLocale;
            if (codes.length == 1) {
              newLocale = Locale(codes[0]);
            } else {
              newLocale = Locale(codes[0], codes[1]);
            }
            setState(() {
              S.load(newLocale);
              _locale = newValue;
            });
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
