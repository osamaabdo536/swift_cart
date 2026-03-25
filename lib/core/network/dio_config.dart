import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:swift_cart/core/utils/secure_storage_helper.dart';
import 'api_constants.dart';

class DioConfig {
  DioConfig._();

  static final Duration timeout = const Duration(seconds: 30);

  static Dio getDio() {
    Dio dio = Dio()
      ..options.baseUrl = ApiConstants.baseUrl
      ..options.connectTimeout = timeout
      ..options.receiveTimeout = timeout
      ..options.responseType = ResponseType.json
      ..options.contentType = 'application/json'
      ..interceptors.addAll([
        AuthInterceptor(),
      ]);
    return dio;
  }
}

class AuthInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorageHelper.instance.getToken();
    debugPrint('TOKEN =====> $token');

    if (token != null && token.isNotEmpty) {
      options.headers['token'] = token;
    }

    debugPrint('Request to: ${options.path}');
    debugPrint('Headers: ${options.headers}');
    handler.next(options);
  }
}