import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences _prefs;
  static const myFavoritesKey = "MyFavorites";
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  LocalStorage._internal() {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.getInstance().then((value) => _prefs = value);
  }

  List<String> getMyFavorites() {
    return _prefs.containsKey(myFavoritesKey)
        ? _prefs.getStringList(myFavoritesKey)!
        : [];
  }

  void setMyFavorites(List<String> data) {
    _prefs.setStringList(myFavoritesKey, data);
  }
}
