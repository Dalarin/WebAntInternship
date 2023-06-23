import 'package:webant_internship/generated/l10n.dart';

import '../resources/resources.dart';

extension ErrorEnumExtension on ErrorEnum {
  String message(S localization) {
    switch (this) {
      case ErrorEnum.badRequest:
        return localization.badRequest;
      case ErrorEnum.forbidden:
        return localization.forbidden;
      case ErrorEnum.notFound:
        return localization.notFound;
      case ErrorEnum.conflict:
        return localization.conflict;
      case ErrorEnum.unauthorized:
        return localization.unathorized;
      case ErrorEnum.serverUnavailable:
        return localization.serverUnavailable;
      case ErrorEnum.serverTemporaryUnavailable:
        return localization.serverUnavailable;
      case ErrorEnum.noInternetConnection:
        return localization.noEthernetError;
      case ErrorEnum.duplicate:
        return localization.duplicate;
      case ErrorEnum.timeOut:
        return localization.timeOut;
      case ErrorEnum.unknown:
        return localization.somethingWentWrong;
    }
  }
}
