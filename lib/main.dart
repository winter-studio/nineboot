import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_content.dart';
import 'app_footer.dart';
import 'app_logo.dart';
import 'generated/l10n.dart';
import 'local_storage.dart';

void main() {
  LocalStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'NineBoot';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // i18n
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: _title,
      home: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            const AppLogo(),
            const Expanded(child: AppContent()),
            Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const AppFooter())
          ],
        ),
      )),
    );
  }
}
