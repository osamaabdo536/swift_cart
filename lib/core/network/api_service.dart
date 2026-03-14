import 'package:dio/dio.dart';
import 'package:swift_cart/core/network/dio_config.dart';
import '../../features/product/model/products_model.dart';
import 'api_exception.dart';
import 'api_constants.dart';

class ApiService{
  ApiService._();
  static final ApiService instance = ApiService._();

  final Dio _dio = DioConfig.getDio();

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await _dio.get(ApiConstants.productsEndPoint);
      return ProductsResponse.fromJson(response.data).data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}