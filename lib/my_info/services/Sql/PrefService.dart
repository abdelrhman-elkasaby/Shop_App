import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static SharedPreferences _preferences;
  static PrefService _instance;

  static Future<PrefService> getInstance() async {
    if (_instance == null) {
      _instance = PrefService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  void setUserData({
    @required Map<String, dynamic> data,
  }) {
    _preferences.setString('userData', json.encode(data));
  }

  Map getUserData() {
    final dataStr = _preferences.getString('userData');
    if (dataStr == null) return null;
    return json.decode(dataStr);
  }

  Future<bool> clearUserData() async {
    return await _preferences.clear();
  }

  bool get isShowIntro => _preferences.getBool("isShowIntro") ?? true;
  set isShowIntro(bool value) => _preferences.setBool("isShowIntro", value);

  bool get isLogin => _preferences.getBool("isLogin") ?? false;
  set isLogin(bool value) => _preferences.setBool("isLogin", value);

  String get userLocal => _preferences.getString("userLocal") ?? "ar";
  set userLocal(String value) => _preferences.setString("userLocal", value);

  String get firebaseToken => _preferences.getString("firebaseToken") ?? "123";
  set firebaseToken(String value) =>
      _preferences.setString("firebaseToken", value);

  String get userToken => _preferences.getString("userToken") ?? "";
  set userToken(String value) => _preferences.setString("userToken", value);

  bool get isOnline => _preferences.getBool("isOnline") ?? true;
  set isOnline(bool value) => _preferences.setBool("isOnline", value);

  bool get liveApp => _preferences.getBool("liveonApp") ?? true;
  set liveApp(bool value) => _preferences.setBool("liveonApp", value);


  String get countryId => _preferences.getString("countryId") ?? "";
  set countryId(String value) => _preferences.setString("countryId", value);

  String get countryName => _preferences.getString("countryName") ?? "";
  set countryName(String value) => _preferences.setString("countryName", value);

}
