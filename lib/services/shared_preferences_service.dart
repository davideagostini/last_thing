import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesServiceProvider =
    Provider<SharedPreferenceService>((ref) => throw UnimplementedError());

class SharedPreferenceService {
  SharedPreferenceService(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  Future<void> putBool(String key, bool value) async {
    sharedPreferences.setBool(key, value);
  }

  bool? getBool(String key) {
    return sharedPreferences.getBool(key);
  }

  Future<void> putString(String key, String value) async {
    sharedPreferences.setString(key, value);
  }

  String? getString(String key) {
    return sharedPreferences.getString(key);
  }
}
