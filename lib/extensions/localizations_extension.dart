import 'package:flutter/material.dart';

import '../generated/l10n.dart';

extension LocalizationsExtension on BuildContext {
  S get localizations => S.of(this);

  String get getCountryCode => Localizations.localeOf(this).languageCode;

}