import 'package:flutter/material.dart';

/// App themes
class AppThemes {
  /// Colors used in the app
  static const primaryColor = Color(0xff0D72FF);
  static const onPrimaryColor = Color(0xff2C3035);

  static const backgroundColor = Color(0xffF6F6F9);
  static const onBackgroundColor = Color(0xffFFFFFF);

  static const secondaryColor = Color(0xffFFA800);
  static const onSecondaryColor = Color(0xffFFFFFF);

  static const surfaceColor = Color(0xffE8E9EC);
  static const onSurfaceColor = Color(0xff828796);

  /// Colors related to errors
  static const errorColor = Color(0xffEB5757);
  static const onErrorColor = Color(0xff14142B);

  /// Colors related to text
  static const primaryTextColor = Color(0xff000000);
  static const secondaryTextColor = Color(0xff828796);
  static const tertiaryTextColor = Color(0xffA9ABB7);
  static const buttonTextColor = Color(0xffFFFFFF);
  static const extraTextColor = Color(0xff2C3035);

  /// Default light theme
  static ThemeData defaultTheme = ThemeData(
    brightness: Brightness.light,
    splashColor: Colors.transparent, // <- Here
    highlightColor: Colors.transparent, // <- Here
    hoverColor: Colors.transparent,
    textTheme: textTheme,
    fontFamily: 'SF Display Pro',

    /// Scheme of colors for this theme
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      secondary: secondaryColor,
      primaryContainer: primaryColor.withOpacity(0.1),
      secondaryContainer: secondaryColor.withGreen(-31).withOpacity(0.2),
      onSecondary: onSecondaryColor,
      error: errorColor,
      errorContainer: const Color(0xffFCE6E6),
      onError: onErrorColor,
      background: backgroundColor,
      onBackground: onBackgroundColor,
      surface: surfaceColor,
      onSurface: onSurfaceColor,
    ),

    /// Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          textTheme.bodyLarge,
        ),
        backgroundColor: MaterialStateProperty.all(primaryColor),
        elevation: MaterialStateProperty.all(0),
        minimumSize: MaterialStateProperty.all(
          const Size(500, 48),
        ),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
      ),
    ),

    /// App bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: onBackgroundColor,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: onBackgroundColor,
      actionsIconTheme: const IconThemeData(
        size: 32,
        color: primaryTextColor,
      ),
      titleTextStyle: textTheme.displaySmall,
    ),

    /// TextField decoration
    inputDecorationTheme: InputDecorationTheme(
      alignLabelWithHint: false,
      filled: true,
      fillColor: backgroundColor,
      labelStyle: textTheme.titleMedium,
      errorStyle: const TextStyle(fontSize: 0),
    ),
  );

  /// App's text theme
  static const textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w500,
      color: primaryTextColor,
      letterSpacing: 0.1,
    ),
    displaySmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: primaryTextColor,
      letterSpacing: 0.1,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: primaryTextColor,
      letterSpacing: 0.1,
    ),
    titleMedium: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: tertiaryTextColor,
      letterSpacing: 0.1,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: primaryTextColor,
      letterSpacing: 0.1,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: secondaryTextColor,
      letterSpacing: 0.1,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: secondaryTextColor,
      letterSpacing: 0.1,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: secondaryTextColor,
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: secondaryTextColor,
      letterSpacing: 0.1,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: secondaryTextColor,
      letterSpacing: 0.1,
    ),
  );
}
