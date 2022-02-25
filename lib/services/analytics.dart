import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class Analytics {
  static final _firebaseAnalytics = FirebaseAnalytics();

  static get firebaseAnalytics => _firebaseAnalytics;

  static bool get skip => kDebugMode;

  // static Future<void> setUserProperties(UserData user) async {
  //   if (skip) return;
  //   // _firebaseAnalytics.setUserId(user.id);
  // }

  static Future<void> trackEvent(String name) async {
    if (skip) return;
    _firebaseAnalytics.logEvent(name: name);
  }

  static Future<void> trackEventCheck(bool check, String name) async {
    trackEvent('$name${check ? '_check' : '_uncheck'}');
  }
}
