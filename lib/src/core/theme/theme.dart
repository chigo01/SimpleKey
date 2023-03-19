import 'package:flutter/material.dart';
import 'package:simple_key/src/core/theme/color_pallter.dart';

class AppTheme {
  static ThemeData light = ThemeData(
      brightness: Brightness.light,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColor.primaryColor.withOpacity(0.2),
        filled: false,
      ),
      scaffoldBackgroundColor: AppColor.scaFoldBackgroundColor,
      primaryColor: AppColor.primaryColor,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColor.scaFoldBackgroundColor,
        centerTitle: true,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.black.withOpacity(0.1), // Colors.white.withOpacity(0.2),
        elevation: 3,
      ));
}
