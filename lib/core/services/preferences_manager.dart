import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  // Data type                     ///ده هيبقا فيه شغل  شويه
  static final PreferencesManager _instance = PreferencesManager._internal();

  //Factory  constractor to return singleton instance
  factory PreferencesManager() {
    return _instance;
  }

  //name constractor privite
  PreferencesManager._internal();


  late final  SharedPreferences _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }
  
  String? getString(String key) {
    return _preferences.getString(key);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }


  // ───────────────── Int ─────────────────
  int? getInt(String key) => _preferences.getInt(key);

  Future<bool> setInt(String key, int value) => _preferences.setInt(key, value);

  // ───────────────── Remove / Clear ─────────────────
  Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }

  Future<bool> clear()async => await _preferences.clear();
}

//final pref = await SharedPreferences.getInstance();
