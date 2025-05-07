import 'package:dio/dio.dart';

import 'errors.dart';
import 'failures.dart';

class DioExceptions implements Exception {
  late Failure failure;

  DioExceptions.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = ErrorTypes.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return ErrorTypes.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return ErrorTypes.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return ErrorTypes.RECIEVE_TIMEOUT.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return NetworkErrorFailure(
            responseCode: error.response?.statusCode ?? 0,
            message: error.response?.data["message"] ?? "");
      } else {
        return ErrorTypes.BAD_REQUEST.getFailure();
      }
    case DioExceptionType.cancel:
      return ErrorTypes.CANCEL.getFailure();
    default:
      return ErrorTypes.DEFAULT.getFailure();
  }
}
