import 'package:flutter/material.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/themes/defaults.dart';

class HabiTheme {
  HabiTheme._();

  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      toolbarTextStyle: TextStyle(
        color: HabiColor.blue,
        fontSize: 26,
      ),
      iconTheme: IconThemeData(
        color: HabiColor.blue,
      ),
      elevation: 0,
      backgroundColor: HabiColor.white,
      titleTextStyle: TextStyle(
        color: HabiColor.blue,
        fontSize: 25,
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: const TextStyle(
        fontSize: 24,
      ),
      subtitleTextStyle: const TextStyle(
        fontSize: 14,
      ),
      style: ListTileStyle.list,
      tileColor: HabiColor.orange,
      textColor: HabiColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    brightness: Brightness.light,
    primaryColor: HabiColor.orange,
    scaffoldBackgroundColor: HabiColor.white,
    textTheme: HabiThemeDefaults.getTextTheme(Brightness.light),
    elevatedButtonTheme: HabiThemeDefaults.elevatedButtonDefaults,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(HabiColor.blue),
        overlayColor: MaterialStateProperty.all<Color>(HabiColor.grayLight),
      ),
    ),
    fontFamily: HabiThemeDefaults.fontFamily,
    textSelectionTheme:
        HabiThemeDefaults.textSelectionThemeDataDefault(HabiColor.orange),
    inputDecorationTheme: HabiThemeDefaults.getInputDecorationThemeCustomBg(
      background: HabiColor.grayLight,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0,
      toolbarTextStyle: TextStyle(
        color: HabiColor.white,
      ),
      iconTheme: IconThemeData(
        color: HabiColor.white,
      ),
      backgroundColor: HabiColor.blue,
      titleTextStyle: TextStyle(
        color: HabiColor.white,
        fontSize: 25,
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: const TextStyle(
        fontSize: 24,
      ),
      subtitleTextStyle: const TextStyle(
        fontSize: 14,
      ),
      style: ListTileStyle.list,
      tileColor: HabiColor.blueDark,
      textColor: HabiColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    brightness: Brightness.dark,
    primaryColor: HabiColor.blue,
    scaffoldBackgroundColor: HabiColor.blue,
    textTheme: HabiThemeDefaults.getTextTheme(Brightness.dark),
    elevatedButtonTheme: HabiThemeDefaults.elevatedButtonDefaults,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(HabiColor.white),
        overlayColor: MaterialStateProperty.all<Color>(HabiColor.blueDark),
      ),
    ),
    fontFamily: HabiThemeDefaults.fontFamily,
    textSelectionTheme:
        HabiThemeDefaults.textSelectionThemeDataDefault(HabiColor.white),
    inputDecorationTheme: HabiThemeDefaults.getInputDecorationThemeCustomBg(
      background: HabiColor.blueLight,
    ),
  );
}
