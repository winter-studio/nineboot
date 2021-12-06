import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences? _prefs;
  static const autoConnect = "autoConnect";
  static const locale = "locale";
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  LocalStorage._internal() {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.getInstance().then((value) => _prefs = value);
  }

  String? getAutoConnect() {
    return _prefs?.getString(autoConnect);
  }

  String? getLocale() {
    return _prefs?.getString(locale);
  }

  void setAutoConnect(String data) {
    _prefs?.setString(autoConnect, data);
  }

  void setLocale(String data) {
    _prefs?.setString(locale, data);
  }
}
