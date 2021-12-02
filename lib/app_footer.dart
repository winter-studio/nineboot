import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nineboot/generated/l10n.dart';

class AppFooter extends StatefulWidget {
  const AppFooter({Key? key}) : super(key: key);

  @override
  State<AppFooter> createState() => _AppFooterState();
}

class _AppFooterState extends State<AppFooter> {
  String locale = Intl.systemLocale;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: locale,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          locale = newValue!;
        });
      },
      items: S.delegate.supportedLocales
          .map<DropdownMenuItem<String>>((Locale locale) {
        return DropdownMenuItem<String>(
          value: locale.languageCode,
          child: Text(locale.languageCode),
        );
      }).toList(),
    );
  }
}
