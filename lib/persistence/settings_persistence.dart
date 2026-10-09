import 'package:shared_preferences/shared_preferences.dart';

class SettingsPersistence {
  Future<void> saveSettings(String username, String password) async {
    final prefs = SharedPreferencesAsync();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }

  Future<Map<String, String>> loadSettings() async {
    final prefs = SharedPreferencesAsync();
    final username = await prefs.getString('username') ?? '';
    final password = await prefs.getString('password') ?? '';
    return {
      'username': username,
      'password': password,
    };
  }
}
