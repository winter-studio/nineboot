import 'package:flutter/material.dart';
import 'package:nineboot/app_main.dart';

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
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            child: const AppMain()),
      )),
    );
  }
}
