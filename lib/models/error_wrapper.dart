import 'package:webant_internship/utils/enums.dart';

class ErrorWrapper {
  final ErrorEnum currentError;
  final String? message;

  const ErrorWrapper({
    this.currentError = ErrorEnum.all,
    this.message,
  });
}