import 'package:flutter/material.dart';

import 'generated/l10n.dart';

class AppFooter extends StatefulWidget {
  const AppFooter({Key? key}) : super(key: key);

  @override
  State<AppFooter> createState() => _AppFooterState();
}

class _AppFooterState extends State<AppFooter> {
  String locale = 'en';
  List<Locale> locales = S.delegate.supportedLocales;

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
          value: locale,
          onChanged: (String? newValue) {
            S.load(Locale.fromSubtags(languageCode: newValue!));
            setState(() {
              locale = newValue;
            });
          },
          items: locales.map<DropdownMenuItem<String>>((Locale value) {
            return DropdownMenuItem<String>(
              value: value.languageCode,
              child: Text(value.languageCode),
            );
          }).toList(),
        )),
      ],
    );
  }
}
