import 'package:flutter/material.dart';

class AppTheme {
  late double _textHeight;
  late String _fontName;

  AppTheme() {
    _fontName = "Rabar";
    _textHeight = 1;
  }

  ThemeData getDarkThemeData() {
    final ThemeData themeData = ThemeData(
      colorSchemeSeed: const Color(0xff2d8144),
      useMaterial3: true,
      brightness: Brightness.dark,
      navigationBarTheme: NavigationBarThemeData(
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 22,
        ),
        errorMaxLines: 5,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(width: 1, color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            width: 0.5,
            color: Colors.white,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.white),
        ),
        errorStyle: TextStyle(
          height: _textHeight,
          fontSize: 16,
          fontFamily: '${_fontName}Book',
        ),
        hintStyle: TextStyle(
          height: _textHeight,
          fontSize: 16,
          fontFamily: '${_fontName}Book',
        ),
      ),
      textTheme: getTextTheme(Colors.white),
    );

    return themeData;
  }

  ThemeData getLightThemeData() {
    final ThemeData themeData = ThemeData(
      colorSchemeSeed: const Color(0xff2d8144),
      useMaterial3: true,
      brightness: Brightness.light,
      navigationBarTheme: NavigationBarThemeData(
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 22,
        ),
        errorMaxLines: 5,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(width: 2, color: Colors.black),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(width: 2, color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(width: 1, color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            width: 0.5,
            color: Colors.black,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.black),
        ),
        errorStyle: TextStyle(
          height: _textHeight,
          fontSize: 16,
          color: Colors.red,
          fontFamily: '${_fontName}Book',
        ),
        hintStyle: TextStyle(
          height: _textHeight,
          fontSize: 16,
          fontFamily: '${_fontName}Book',
        ),
      ),
      textTheme: getTextTheme(Colors.black),
    );

    return themeData;
  }

  TextTheme getTextTheme(Color color) {
    return TextTheme(
      displayLarge: TextStyle(
        height: _textHeight,
        fontSize: 24,
        fontFamily: '${_fontName}Bold',
        color: color,
      ),
      displayMedium: TextStyle(
        height: _textHeight,
        fontSize: 18,
        fontFamily: '${_fontName}Bold',
        color: color,
      ),
      displaySmall: TextStyle(
        height: _textHeight,
        fontSize: 18,
        fontFamily: '${_fontName}Medium',
        color: color,
      ),
      headlineMedium: TextStyle(
        height: _textHeight,
        fontSize: 18,
        fontFamily: '${_fontName}Book',
        color: color,
      ),
      titleMedium: TextStyle(
        height: _textHeight,
        fontSize: 14,
        fontFamily: '${_fontName}Medium',
        color: color,
      ),
      titleSmall: TextStyle(
        height: _textHeight,
        fontSize: 14,
        fontFamily: '${_fontName}Book',
        color: color,
      ),
      bodyLarge: TextStyle(
        height: _textHeight,
        fontSize: 12,
        fontFamily: '${_fontName}Medium',
        color: color,
      ),
      bodyMedium: TextStyle(
        height: _textHeight,
        fontSize: 12,
        fontFamily: '${_fontName}Book',
        color: color,
      ),
      bodySmall: TextStyle(
        height: _textHeight,
        fontSize: 10,
        fontFamily: '${_fontName}Book',
        color: color,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontFamily: '${_fontName}Bold',
        color: Colors.white,
      ),
    );
  }
}
