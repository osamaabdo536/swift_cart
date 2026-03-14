import 'package:dio/dio.dart';

class ApiException {
  final String errorMessage;
  final int? errorCode;

  const ApiException({required this.errorMessage, this.errorCode});

  static ApiException fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
        return const ApiException(errorMessage: 'Timeout, please try again');
      case DioExceptionType.badCertificate:
        return const ApiException(errorMessage: 'Bad certificate');
      case DioExceptionType.connectionError:
        return const ApiException(
          errorMessage: 'Connection error, check your internet connection',
        );
      case DioExceptionType.badResponse:
      case DioExceptionType.unknown:
        return ApiException(
          errorMessage:
          error.response?.statusMessage ??
              error.message ??
              'Something went wrong',
          errorCode: error.response?.statusCode,
        );
      default:
        return const ApiException(errorMessage: 'Something went wrong');
    }
  }
}