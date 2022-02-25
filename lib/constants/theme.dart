import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifter/constants/text_styles.dart';
import 'package:lifter/constants/theme_colors.dart';

final ThemeData theme = ThemeData(
  brightness: Brightness.light,
  backgroundColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  inputDecorationTheme: InputDecorationTheme(
    // errorStyle: const TextStyle(
    //   color: Colors.transparent,
    //   height: 0.0,
    // ),
    hintStyle: const TextStyle(
      color: ThemeColors.textGrey,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        color: ThemeColors.borderGrey,
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        color: ThemeColors.borderGrey,
        width: 1,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        color: ThemeColors.borderGrey,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: ThemeColors.blue),
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    modalBackgroundColor: Colors.transparent,
  ),
  textTheme: TextTheme(
    subtitle1: TextStyles.bold, // ListTile.title
    subtitle2: TextStyles.faded,
    bodyText1: TextStyles.bold,
    bodyText2: TextStyles.normal, // ListTile.subtitle
  ),
  listTileTheme: ListTileThemeData(
    minLeadingWidth: 40,
    contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
  ),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: const {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
    },
  ),
);
