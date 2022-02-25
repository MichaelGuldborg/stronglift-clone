import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const backgroundMessageKey = 'x-background-message';
  static const currentUserKey = 'x-current-user';

  static Future<Map<String, dynamic>> getMap(String key, {Map<String, dynamic> fallback = const {}}) async {
    final json = await getString(key);
    if (json.isEmpty) return {};
    return jsonDecode(json);
  }

  static Future<bool> setMap(String key, Map<String, dynamic> map) async {
    final json = jsonEncode(map);
    return await setString(key, json);
  }

  static Future<bool> setDateTime(String key, DateTime dateTime) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, dateTime.toIso8601String());
  }

  static Future<DateTime?> getDateTime(String key, {DateTime? fallback}) async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(key);
    return s != null ? DateTime.parse(s) : fallback;
  }

  static Future<bool> setString(String key, String text) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, text);
  }

  static Future<String> getString(String key, {String fallback = ''}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? fallback;
  }

  // static Future<bool> setBackgroundMessage(RemoteMessage message) async {
  //   final notification = PushNotification.fromRemoteMessage(message);
  //   final json = jsonEncode(notification.toMap());
  //   return await setString(backgroundMessageKey, json);
  // }
  //
  // static Future<PushNotification?> getBackgroundMessage() async {
  //   final json = await getString(backgroundMessageKey);
  //   setString(backgroundMessageKey, '');
  //   if (json.isEmpty) return null;
  //   final map = jsonDecode(json);
  //   return PushNotification.fromMap(map);
  // }
  //
  // static Future<UserData> getCurrentUser() async {
  //   final map = await getMap(currentUserKey);
  //   return UserData.fromMap(map);
  // }
  //
  // static setCurrentUser(UserData user) {
  //   return setMap(currentUserKey, user.toMap());
  // }
}
