import 'package:shared_preferences/shared_preferences.dart';

import '../../base/dependency.dart';

final class SharedPreferencesStorageService implements Service {
  const SharedPreferencesStorageService(this._preferences);

  final SharedPreferences _preferences;

  bool getBool(String key, {bool defaultValue = false}) {
    return _preferences.getBool(key) ?? defaultValue;
  }

  Future<void> setBool(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  Future<void> remove(String key) {
    return _preferences.remove(key);
  }
}
