import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'preferences_exception.dart';

abstract class PreferencesManager {
  setBoolData(String key, bool value);
  setStringData(String key, String value);
  setObject(Map jsonObject, String preferencesName);
  bool getBoolData(String key);
  String getStringData(String key);
  Map getObject(String objectName);
}

class PreferencesManagerImpl extends PreferencesManager {
  SharedPreferences _prefs;
  PreferencesManagerImpl(this._prefs);

  @override
  setBoolData(String key, bool value) async {
    await _prefs.setBool(key, value).catchError( (error) { throw SharedPreferencesException(); });
  }

  @override
  setStringData(String key, String value) async {
    await _prefs.setString(key, value).catchError( (error) { throw SharedPreferencesException(); });
  }

  @override
  bool getBoolData(String key) {
    return _prefs.getBool(key);
  }

  @override
  String getStringData(String key) {
    return _prefs.getString(key);
  }
  @override
  setObject(Map jsonObject, String preferencesName) {
    String jsonString = jsonEncode(jsonObject);
    _prefs.setString(preferencesName, jsonString).catchError( (error) { throw SharedPreferencesException(); });
  }

  @override
  Map getObject(String objectName) {
    final jsonString = _prefs.getString(objectName);
    if (jsonString == null) throw SharedPreferencesException();
    Map json = jsonDecode(jsonString);
    if (json == null) throw SharedPreferencesException();
    return json;
  }
}