import 'package:flutter/material.dart';

import 'app_content.dart';
import 'app_logo.dart';

void main() {
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
          children: const [AppLogo(), AppContent()],
        ),
      )),
    );
  }
}
