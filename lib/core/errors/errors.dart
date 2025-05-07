

import 'package:easy_localization/easy_localization.dart';
import 'package:sloopify_mobile/core/errors/failures.dart';
import 'package:sloopify_mobile/core/managers/string_managers.dart';

enum ErrorTypes {
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  ERROR_FETCHING_IP,
  DEVICE_INFO_ERROR,
  DEFAULT
}

extension DataSourceExtension on ErrorTypes {
  Failure getFailure() {
    switch (this) {
      case ErrorTypes.NO_CONTENT:
        return NetworkErrorFailure(
            responseCode: ResponseCode.NO_CONTENT,
            message: ResponseMessage.NO_CONTENT);
      case ErrorTypes.BAD_REQUEST:
        return NetworkErrorFailure(
            responseCode: ResponseCode.BAD_REQUEST,
            message: ResponseMessage.BAD_REQUEST);
      case ErrorTypes.FORBIDDEN:
        return NetworkErrorFailure(
            responseCode: ResponseCode.FORBIDDEN,
            message: ResponseMessage.FORBIDDEN);
      case ErrorTypes.UNAUTORISED:
        return NetworkErrorFailure(
            responseCode: ResponseCode.UNAUTORISED,
            message: ResponseMessage.UNAUTORISED);
      case ErrorTypes.NOT_FOUND:
        return NetworkErrorFailure(
            responseCode: ResponseCode.NOT_FOUND,
            message: ResponseMessage.NOT_FOUND);
      case ErrorTypes.INTERNAL_SERVER_ERROR:
        return NetworkErrorFailure(
            responseCode: ResponseCode.INTERNAL_SERVER_ERROR,
            message: ResponseMessage.INTERNAL_SERVER_ERROR);
      case ErrorTypes.CONNECT_TIMEOUT:
        return NetworkErrorFailure(
            responseCode: ResponseCode.CONNECT_TIMEOUT,
            message: ResponseMessage.CONNECT_TIMEOUT);
      case ErrorTypes.CANCEL:
        return NetworkErrorFailure(
            responseCode: ResponseCode.CANCEL, message: ResponseMessage.CANCEL);
      case ErrorTypes.RECIEVE_TIMEOUT:
        return NetworkErrorFailure(
            responseCode: ResponseCode.RECIEVE_TIMEOUT,
            message: ResponseMessage.RECIEVE_TIMEOUT);
      case ErrorTypes.SEND_TIMEOUT:
        return NetworkErrorFailure(
            responseCode: ResponseCode.SEND_TIMEOUT,
            message: ResponseMessage.SEND_TIMEOUT);
      case ErrorTypes.CACHE_ERROR:
        return NetworkErrorFailure(
            responseCode: ResponseCode.CACHE_ERROR,
            message: ResponseMessage.CACHE_ERROR);
      case ErrorTypes.NO_INTERNET_CONNECTION:
        return OfflineFailure();
      case ErrorTypes.DEFAULT:
        return NetworkErrorFailure(
            responseCode: ResponseCode.DEFAULT,
            message: ResponseMessage.DEFAULT);

      case ErrorTypes.ERROR_FETCHING_IP:
        return NetworkErrorFailure(
            responseCode: ResponseCode.IP_ERROR,
            message: ResponseMessage.IP_ADDRESS_ERROR);

      case ErrorTypes.DEVICE_INFO_ERROR:
        return NetworkErrorFailure(
            responseCode: ResponseCode.DEVICE_INFO_ERROR,
            message: ResponseMessage.DEVICE_INFO_ERROR);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST =
      400; // NetworkErrorFailure, API rejected request
  static const int UNAUTORISED =
      401; // NetworkErrorFailure, user is not authorised
  static const int FORBIDDEN =
      403; //  NetworkErrorFailure, API rejected request
  static const int INTERNAL_SERVER_ERROR =
      500; // NetworkErrorFailure, crash in server side
  static const int NOT_FOUND = 404; // NetworkErrorFailure, not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;

  //
  static const int IP_ERROR = -8;
  static const int DEVICE_INFO_ERROR = -9;
}

class ResponseMessage {
  static String SUCCESS = 'success'.tr(); // success with data
  static String NO_CONTENT =
      'success'.tr(); // success with no data (no content)
  static const String BAD_REQUEST = AppStrings
      .strBadRequestError; // NetworkErrorFailure, API rejected request
  static const String UNAUTORISED = AppStrings
      .strUnauthorizedError; // NetworkErrorFailure, user is not authorised
  static const String FORBIDDEN = AppStrings
      .strForbiddenError; //  NetworkErrorFailure, API rejected request
  static const String INTERNAL_SERVER_ERROR = AppStrings
      .strInternalServerError; // NetworkErrorFailure, crash in server side
  static const String NOT_FOUND =
      AppStrings.strNotFoundError; // NetworkErrorFailure, crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = AppStrings.strTimeoutError;
  static const String CANCEL = AppStrings.strDefaultError;
  static const String RECIEVE_TIMEOUT = AppStrings.strTimeoutError;
  static const String SEND_TIMEOUT = AppStrings.strTimeoutError;
  static const String CACHE_ERROR = AppStrings.strCacheError;
  static const String NO_INTERNET_CONNECTION = AppStrings.strNoInternetError;
  static const String DEFAULT = AppStrings.strDefaultError;
  static const String IP_ADDRESS_ERROR = AppStrings.strErrorFetchingIPAddress;

  static const String DEVICE_INFO_ERROR = AppStrings.strDeviceInfoError;
}
