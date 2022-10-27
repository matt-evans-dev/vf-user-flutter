import 'package:flutter/material.dart';

import 'colors.dart';
import 'font_family.dart';

final ThemeData themeData = new ThemeData(
  fontFamily: AppFontFamily.montserrat,
  brightness: Brightness.light,
  primaryColor: AppColors.green1,
  primaryColorBrightness: Brightness.light,
  secondaryHeaderColor: AppColors.cyan1,
  accentColor: AppColors.black1,
  accentColorBrightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.white,
  bottomAppBarColor: AppColors.white,
  backgroundColor: AppColors.white,
  dialogBackgroundColor: AppColors.white,
  dividerColor: AppColors.black1,
  cardColor: AppColors.grey6,
  textTheme: TextTheme(
    headline5: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
      color: Colors.white,
    ),
    headline6: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: AppColors.black1,
    ),
    subtitle1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: AppColors.black1,
    ),
    subtitle2: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColors.grey1,
    ),
    bodyText1: TextStyle(
      fontSize: 11.0,
      color: Colors.black.withOpacity(0.65),
    ),
    // Default text style
    bodyText2: TextStyle(
      fontSize: 12.0,
      color: AppColors.grey1,
    ),
    button: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    caption: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    overline: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  ),
);

final ThemeData darkThemeData = ThemeData(
  fontFamily: AppFontFamily.montserrat,
  brightness: Brightness.dark,
  primaryColor: AppColors.green1,
  primaryColorBrightness: Brightness.dark,
  secondaryHeaderColor: AppColors.darkGreen,
  accentColor: AppColors.white,
  accentColorBrightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  bottomAppBarColor: AppColors.black1,
  backgroundColor: Colors.black,
  dialogBackgroundColor: Colors.black,
  dividerColor: AppColors.white,
  cardColor: AppColors.black4,
  textTheme: TextTheme(
    headline6: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: AppColors.white,
    ),
    subtitle1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
    subtitle2: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
    bodyText1: TextStyle(
      fontSize: 11.0,
      color: Colors.white,
    ),
    // Default text style
    bodyText2: TextStyle(
      fontSize: 12.0,
      color: AppColors.white,
    ),
    button: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    // Card title.
    caption: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    overline: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  ),
);

LinearGradient kCardGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.black.withOpacity(0.1),
    Colors.black87.withOpacity(0.2),
    Colors.black54.withOpacity(0.3),
    Colors.black38.withOpacity(0.4),
  ],
  stops: [0.1, 0.4, 0.6, 0.9],
);

BoxShadow kCardShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.5),
  spreadRadius: 2,
  blurRadius: 2,
  offset: Offset(0, 0), // changes position of shadow
);
