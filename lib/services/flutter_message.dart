import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:lifter/constants/theme_colors.dart';

void showSuccess(String? text) {
  return FlutterMessage.instance.showSuccess(text);
}

void showError(String? text) {
  return FlutterMessage.instance.showError(text);
}

class FlutterMessage {
  static final _instance = FlutterMessage();

  static FlutterMessage get instance => _instance;

  final Duration duration = Duration(seconds: 4);

  void showSuccess(String? text) {
    if (text == null || text.isEmpty) return;
    BotToast.showCustomNotification(
      duration: duration,
      toastBuilder: (cancel) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          width: double.maxFinite,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ThemeColors.lightGreen,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: ThemeColors.darkGreen,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        );
      },
    );
  }

  void showError(String? text) {
    if (text == null || text.isEmpty) return;
    BotToast.showCustomNotification(
      duration: duration,
      toastBuilder: (cancel) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          width: double.maxFinite,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ThemeColors.lightRed,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: ThemeColors.darkRed,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        );
      },
    );
  }
}

