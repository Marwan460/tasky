import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  PreferencesManager._();

  static final PreferencesManager _instance = PreferencesManager._();

  factory PreferencesManager() {
    return _instance;
  }

  late final SharedPreferences _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  Future<bool> setString(String key, String value) async{
    return await _preferences.setString(key, value);
  }

  remove(String key) async{
    await _preferences.remove(key);
  }

  Future<bool> setBool(String key, bool value) async{
    return await _preferences.setBool(key, value);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }
}
