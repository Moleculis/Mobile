import 'package:easy_localization/easy_localization.dart';

class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, '${'communication_error'.tr()}: ');
}

class BadRequestException extends AppException {
  BadRequestException([message])
      : super(message, '${'invalid_request'.tr()}: ');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, '${'unauthorised'.tr()}: ');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super(message, '${'invalid_input'.tr()}: ');
}
