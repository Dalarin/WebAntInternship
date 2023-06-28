import 'package:webant_internship/resources/app_enums.dart';

class ValidatorHelper {
  static Map<Fields, FieldsError>? validateEmail(String email) {
    if (email.trim().isEmpty) {
      return {Fields.emailField: FieldsError.emptyField};
    }

    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return {Fields.emailField: FieldsError.emailError};
    }

    return null;
  }

  static Map<Fields, FieldsError>? validatePassword(String password) {
    if (password.trim().isEmpty) {
      return {Fields.passwordField: FieldsError.emptyField};
    }

    if (password.trim().length < 8) {
      return {Fields.passwordField: FieldsError.passwordError};
    }
    return null;
  }

  static Map<Fields, FieldsError>? validateField(Fields field, String value) {
    if (value.trim().isEmpty) {
      return {field: FieldsError.emptyField};
    }

    return null;
  }

  static Map<Fields, FieldsError>? validateRepeatField(String firstValue, String secondValue) {
    final value = {
      ...?validateField(Fields.passwordField, firstValue),
      ...?validateField(Fields.repeatPasswordField, secondValue),
      ...?validatePassword(firstValue),
    };

    if (value.keys.isNotEmpty) {
      return value;
    }

    if (firstValue.trim() != secondValue.trim()) {
      value.addAll(
        {
          Fields.passwordField: FieldsError.fieldsNotSimilar,
          Fields.repeatPasswordField: FieldsError.fieldsNotSimilar,
        },
      );
    }

    return value;
  }
}
