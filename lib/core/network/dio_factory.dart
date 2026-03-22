import 'package:dio/dio.dart';

class DioFactory {
  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio(
        BaseOptions(
          baseUrl: "https://ecommerce.routemisr.com/api/v1/",
          connectTimeout: timeOut,
          receiveTimeout: timeOut,
        ),
      );

      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );
  }
}
