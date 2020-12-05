import 'package:flutter/material.dart';

import 'colors.dart';

final mainThemeData = ThemeData(
    backgroundColor: CustomColors.background,
    scaffoldBackgroundColor: CustomColors.background,
    textTheme: mainTextTheme);

final mainTextTheme = TextTheme(
    subtitle1: TextStyle(
        color: CustomColors.headline1,
        fontSize: 14,
        fontWeight: FontWeight.normal),
    subtitle2: TextStyle(
        color: Colors.white, fontSize: 13, fontWeight: FontWeight.normal),
    caption: TextStyle(
        color: Colors.white, fontSize: 10, fontWeight: FontWeight.normal),
    bodyText1: TextStyle(
        color: Colors.white, fontWeight: FontWeight.normal, fontSize: 15),
    bodyText2: TextStyle(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal));

final detailsBgColor = const Color.fromARGB(255, 26, 25, 39);

const double detailsHorizontalPadding = 32;