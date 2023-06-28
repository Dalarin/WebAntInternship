enum Status { initial, loading, success, failure }

enum ErrorEnum {
  badRequest,
  forbidden,
  notFound,
  conflict,
  unauthorized,
  serverUnavailable,
  serverTemporaryUnavailable,
  noInternetConnection,
  duplicate,
  timeOut,
  unknown
}

enum Fields {
  emailField,
  passwordField,
  usernameField,
  repeatPasswordField,
  titleField,
  descriptionField;
}


enum FieldsError {
  emptyField, emailError, passwordError, fieldsNotSimilar
}