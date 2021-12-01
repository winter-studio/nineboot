// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Selected Device`
  String get selectedDevice {
    return Intl.message(
      'Selected Device',
      name: 'selectedDevice',
      desc: '',
      args: [],
    );
  }

  /// `search`
  String get searchDevice {
    return Intl.message(
      'search',
      name: 'searchDevice',
      desc: '',
      args: [],
    );
  }

  /// `please search and select your device.`
  String get searchDeviceTip {
    return Intl.message(
      'please search and select your device.',
      name: 'searchDeviceTip',
      desc: '',
      args: [],
    );
  }

  /// `connect device timeout`
  String get connectTimeout {
    return Intl.message(
      'connect device timeout',
      name: 'connectTimeout',
      desc: '',
      args: [],
    );
  }

  /// `could not find the characteristic of ninebot`
  String get characteristicNotFound {
    return Intl.message(
      'could not find the characteristic of ninebot',
      name: 'characteristicNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Error`
  String get unknownError {
    return Intl.message(
      'Unknown Error',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknownDevice {
    return Intl.message(
      'Unknown',
      name: 'unknownDevice',
      desc: '',
      args: [],
    );
  }

  /// `Devices`
  String get deviceList {
    return Intl.message(
      'Devices',
      name: 'deviceList',
      desc: '',
      args: [],
    );
  }

  /// `please select your device.`
  String get selectDeviceTip {
    return Intl.message(
      'please select your device.',
      name: 'selectDeviceTip',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `confirm`
  String get confirm {
    return Intl.message(
      'confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Stop Scan`
  String get stopScan {
    return Intl.message(
      'Stop Scan',
      name: 'stopScan',
      desc: '',
      args: [],
    );
  }

  /// `Scan Again`
  String get scanAgain {
    return Intl.message(
      'Scan Again',
      name: 'scanAgain',
      desc: '',
      args: [],
    );
  }

  /// `BOOT`
  String get boot {
    return Intl.message(
      'BOOT',
      name: 'boot',
      desc: '',
      args: [],
    );
  }

  /// `device not found, ensure your device is nearby`
  String get deviceNotFound {
    return Intl.message(
      'device not found, ensure your device is nearby',
      name: 'deviceNotFound',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(
          languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
