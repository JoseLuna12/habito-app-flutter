import 'package:flutter/material.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_measurements.dart';

class HabiThemeDefaults {
  static const String fontFamily = "Poppins";
  static const double buttonRoundness = 10;

  static InputDecorationTheme getInputDecorationThemeCustomBg(
      {required Color background}) {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.fromLTRB(
        HabiMeasurements.paddingLeft,
        0,
        HabiMeasurements.paddingRight,
        0,
      ),
      filled: true,
      fillColor: background,
      hintStyle: const TextStyle(color: HabiColor.gray),
      outlineBorder: BorderSide(
        color: background,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(HabiMeasurements.cornerRadius),
        borderSide: const BorderSide(
          color: HabiColor.dangerDark,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(HabiMeasurements.cornerRadius),
        borderSide: const BorderSide(
          color: HabiColor.orange,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(HabiMeasurements.cornerRadius),
        borderSide: BorderSide(
          color: background,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(HabiMeasurements.cornerRadius),
        borderSide: BorderSide(
          color: background,
        ),
      ),
    );
  }

  static TextSelectionThemeData textSelectionThemeDataDefault(Color color) {
    return TextSelectionThemeData(
      cursorColor: color,
      selectionColor: HabiColor.orangeOverlayColor,
      selectionHandleColor: HabiColor.orange,
    );
  }

  static final ElevatedButtonThemeData elevatedButtonDefaults =
      ElevatedButtonThemeData(
    style: ButtonStyle(
      shadowColor: null,
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRoundness),
        ),
      ),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(vertical: 10),
      ),
      minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.all<Color>(HabiColor.orange),
      foregroundColor: MaterialStateProperty.all<Color>(HabiColor.white),
      overlayColor:
          MaterialStateProperty.all<Color>(HabiColor.orangeOverlayColor),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 16,
        ),
      ),
    ),
  );

  static TextTheme getTextTheme(Brightness brightness) {
    Color color =
        brightness == Brightness.light ? HabiColor.blue : HabiColor.white;

    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 66,
        color: color,
        fontWeight: FontWeight.normal,
      ),
      displayMedium: TextStyle(
        fontSize: 26,
        color: color,
        fontWeight: FontWeight.normal,
      ),
      bodyLarge: const TextStyle(
        fontSize: 26,
        color: HabiColor.orange,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: const TextStyle(
        fontSize: 17,
      ),
      bodySmall: const TextStyle(
        fontSize: 11,
      ),
    );
  }

  // static const TextTheme textThemeDefaults = TextTheme(
  //   displayLarge: TextStyle(
  //     fontSize: 66,
  //     color: HabiColor.blue,
  //     fontWeight: FontWeight.normal,
  //   ),
  //   displayMedium: TextStyle(
  //     fontSize: 26,
  //     color: HabiColor.blue,
  //     fontWeight: FontWeight.normal,
  //   ),
  //   bodyLarge: TextStyle(
  //     fontSize: 26,
  //     color: HabiColor.orange,
  //     fontWeight: FontWeight.normal,
  //   ),
  //   bodyMedium: TextStyle(
  //     fontSize: 17,
  //   ),
  //   bodySmall: TextStyle(
  //     fontSize: 11,
  //   ),
  // );
}
