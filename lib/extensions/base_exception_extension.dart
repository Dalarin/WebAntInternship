import 'package:data/data.dart';

import '../resources/resources.dart';

extension BaseExceptionExtension on BaseException {
  ErrorEnum get errorEnum {
    switch (runtimeType) {
      case BadRequest:
        return ErrorEnum.badRequest;
      case Forbidden:
        return ErrorEnum.forbidden;
      case NotFound:
        return ErrorEnum.notFound;
      case Conflict:
        return ErrorEnum.conflict;
      case Unauthorized:
        return ErrorEnum.unauthorized;
      case ServerUnavailable:
      case ServiceTemporarilyUnavailable:
        return ErrorEnum.serverUnavailable;
      case NoInternetConnection:
        return ErrorEnum.noInternetConnection;
      case Duplicate:
        return ErrorEnum.duplicate;
      default:
        return ErrorEnum.unknown;
    }
  }
}
