import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'api_constants.dart';

class DioConfig {
  DioConfig._();

  static final Duration timeout = const Duration(seconds: 30);

  static Dio getDio({String? token}) {
    Dio dio = Dio()
      ..options.baseUrl = ApiConstants.baseUrl
      ..options.connectTimeout = timeout
      ..options.receiveTimeout = timeout
      ..options.responseType = ResponseType.json
      ..options.contentType = 'application/json'
      ..interceptors.addAll([
        AuthInterceptor(token: token),
      ]);
    return dio;
  }
}

class AuthInterceptor extends InterceptorsWrapper {
  final String? token;
  AuthInterceptor({this.token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token != null && token!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    debugPrint('Request to: ${options.path}');
    debugPrint('Headers: ${options.headers}');
    handler.next(options);
  }
}