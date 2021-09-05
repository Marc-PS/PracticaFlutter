import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;
  static const _keyDoneOption = 'DoneOption';
  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setUserDonePreferences(String chosen) async => await _preferences.setString(_keyDoneOption, chosen);
  
  static String getUserPreferences() => _preferences.getString(_keyDoneOption) ?? 'Nothing';
}