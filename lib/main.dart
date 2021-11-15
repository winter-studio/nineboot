import 'package:flutter/material.dart';

import 'app_content.dart';
import 'app_logo.dart';
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
      debugShowCheckedModeBanner: false,
      title: _title,
      home: SafeArea(
          child: Scaffold(
        body: Column(
          children: [AppLogo(), AppContent()],
        ),
      )),
    );
  }
}
