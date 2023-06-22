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
    colorSchemeSeed: AppColors.primaryColor,
  );
}
