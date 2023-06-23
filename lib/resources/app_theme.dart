import 'package:flutter/material.dart';

import 'resources.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: AppColors.titleColor,
      )
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
    colorSchemeSeed: AppColors.primaryColor,
  );
}
