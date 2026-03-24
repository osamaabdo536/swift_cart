import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException({required this.message, this.statusCode});

  @override
  String toString() => message;

  static ApiException fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
        return const ApiException(
          message: 'Connection timeout, please try again',
        );

      case DioExceptionType.badCertificate:
        return const ApiException(message: 'Bad certificate');

      case DioExceptionType.connectionError:
        return const ApiException(
          message: 'No internet connection, please check your network',
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return const ApiException(message: 'Request cancelled');

      case DioExceptionType.unknown:
        return ApiException(message: error.message ?? 'Something went wrong');
    }
  }

  static ApiException _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    // Try to extract error message from response
    String errorMessage = 'Something went wrong';

    if (data != null) {
      if (data is Map<String, dynamic>) {
        // Check for common error message fields
        errorMessage =
            data['message'] ??
            data['error'] ??
            data['errors']?.toString() ??
            errorMessage;
      } else if (data is String) {
        errorMessage = data;
      }
    }

    // Handle specific status codes
    switch (statusCode) {
      case 400:
        return ApiException(
          message: errorMessage.isNotEmpty ? errorMessage : 'Invalid request',
          statusCode: statusCode,
        );
      case 401:
        return ApiException(
          message: 'Unauthorized, please login again',
          statusCode: statusCode,
        );
      case 403:
        return ApiException(message: 'Access denied', statusCode: statusCode);
      case 404:
        return ApiException(
          message: 'Resource not found',
          statusCode: statusCode,
        );
      case 409:
        return ApiException(
          message: errorMessage.isNotEmpty ? errorMessage : 'Conflict occurred',
          statusCode: statusCode,
        );
      case 422:
        return ApiException(
          message: errorMessage.isNotEmpty ? errorMessage : 'Validation error',
          statusCode: statusCode,
        );
      case 500:
      case 502:
      case 503:
        return ApiException(
          message: 'Server error, please try again later',
          statusCode: statusCode,
        );
      default:
        return ApiException(message: errorMessage, statusCode: statusCode);
    }
  }
}
