import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nineboot/tools/locale_provider.dart';
import 'package:provider/provider.dart';

import 'app_content.dart';
import 'app_footer.dart';
import 'app_logo.dart';
import 'generated/l10n.dart';
import 'tools/local_storage.dart';

void main() {
  LocalStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'NineBoot';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = LocalStorage().getLocale();
    return ChangeNotifierProvider(
        create: (context) => LocaleProvider(locale),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
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
            locale: provider.locale,
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
        });
  }
}
