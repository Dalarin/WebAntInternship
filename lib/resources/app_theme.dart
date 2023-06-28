import 'package:flutter/material.dart';

import 'resources.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: AppColors.titleColor,
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.titleColor,
      behavior: SnackBarBehavior.floating,
    ),
    colorSchemeSeed: AppColors.primaryColor,
    chipTheme: const ChipThemeData(
      labelStyle: TextStyle(
        color: Colors.white,
      ),
      backgroundColor: AppColors.primaryColor,
      side: BorderSide(
        color: Colors.transparent,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      deleteIconColor: Colors.white,
      shape: StadiumBorder(),
    ),
  );
}
