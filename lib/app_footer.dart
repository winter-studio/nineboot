import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nineboot/tools/local_storage.dart';
import 'package:nineboot/tools/locale_provider.dart';
import 'package:nineboot/tools/locale_utils.dart';
import 'package:provider/provider.dart';

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
    setState(() {
      _locale = Intl.getCurrentLocale();
    });
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
            Locale newLocale = LocaleUtils.getLocale(newValue!);
            final provider =
                Provider.of<LocaleProvider>(context, listen: false);
            provider.setLocale(newLocale);
            LocalStorage().setLocale(newValue);
            setState(() {
              _locale = newValue;
              log('change to ' + newValue);
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
