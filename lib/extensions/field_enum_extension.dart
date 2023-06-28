import 'package:webant_internship/generated/l10n.dart';

import '../resources/resources.dart';

extension FieldExtension on Fields {
  String getError(FieldsError error, S localization) {
    return error.message(localization);
  }
}

extension FieldsErrorExtension on FieldsError {
  String message(S localization) {
    switch (this) {
      case FieldsError.emptyField:
        return localization.fillField('');
      case FieldsError.emailError:
        return localization.emailNotValid;
      case FieldsError.passwordError:
        return localization.passwordNotValid;
      case FieldsError.fieldsNotSimilar:
        return localization.passwordsDontMatch;
    }
  }
}
