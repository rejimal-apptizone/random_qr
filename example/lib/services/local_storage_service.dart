import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static Future<SharedPreferences> _getSharedPreferences() {
    return SharedPreferences.getInstance();
  }

  static Future<bool> setStringToLocal({
    @required String key,
    @required String value,
  }) {
    return _getSharedPreferences().then(
      (sharedPreferences) => sharedPreferences.setString(key, value),
    );
  }

  static Future<bool> setIntToLocal({
    @required String key,
    @required int value,
  }) {
    return _getSharedPreferences().then(
      (sharedPreferences) => sharedPreferences.setInt(key, value),
    );
  }

  static Future<bool> setBooleanToLocal({
    @required String key,
    @required bool value,
  }) {
    return _getSharedPreferences().then(
      (sharedPreferences) => sharedPreferences.setBool(key, value),
    );
  }

  static Future<bool> setDoubleToLocal({
    @required String key,
    @required double value,
  }) {
    return _getSharedPreferences().then(
      (sharedPreferences) => sharedPreferences.setDouble(key, value),
    );
  }

  static Future<String> getStringFromLocal({
    @required String key,
  }) {
    return _getSharedPreferences().then(
      (sharedPreferences) => sharedPreferences.getString(key),
    );
  }

  static Future<int> getIntFromLocal({
    @required String key,
  }) {
    return _getSharedPreferences().then(
      (sharedPreferences) => sharedPreferences.getInt(key),
    );
  }

  static Future<bool> getBooleanFromLocal({
    @required String key,
  }) {
    return _getSharedPreferences().then(
      (sharedPreferences) => sharedPreferences.getBool(key),
    );
  }

  static Future<double> getDoubleFromLocal({
    @required String key,
  }) {
    return _getSharedPreferences().then(
      (sharedPreferences) => sharedPreferences.getDouble(key),
    );
  }

  static Future<bool> removeValueFromLocal({
    @required String key,
  }) {
    return _getSharedPreferences().then(
      (sharedPreferences) => sharedPreferences.remove(key),
    );
  }

  static Future<bool> clearLocalStorage() {
    return _getSharedPreferences().then(
      (sharedPreferences) => sharedPreferences.clear(),
    );
  }

  static Future<bool> isKeyAvailable({@required String key}) {
    return _getSharedPreferences().then(
      (sharedPreferences) => sharedPreferences.containsKey(key),
    );
  }
}
