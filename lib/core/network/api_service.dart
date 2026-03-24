import 'package:dio/dio.dart';
import 'package:swift_cart/core/network/dio_config.dart';
import '../../features/product/model/products_model.dart';
import 'api_exception.dart';
import 'api_constants.dart';

class ApiService {
  ApiService._();
  static final ApiService instance = ApiService._();

  final Dio _dio = DioConfig.getDio();

  // Generic methods
  Future<Response> get(String endpoint) async {
    try {
      return await _dio.get(endpoint);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Response> post(String endpoint, {dynamic data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Response> delete(String endpoint) async {
    try {
      return await _dio.delete(endpoint);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // Product methods
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await _dio.get(ApiConstants.productsEndPoint);
      return ProductsResponse.fromJson(response.data).data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<ProductModel> getProductById(String productId) async {
    try {
      final response = await _dio.get(
        "${ApiConstants.productsEndPoint}/$productId",
      );
      return ProductModel.fromJson(response.data["data"]);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  //WISHLIST
  Future<List<String>> addToWishlist(String productId) async {
    try {
      final response = await _dio.post(
        ApiConstants.wishlistEndPoint,
        data: {"productId": productId},
      );

      return List<String>.from(response.data["data"]);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<List<String>> removeFromWishlist(String productId) async {
    try {
      final response = await _dio.delete(
        "${ApiConstants.wishlistEndPoint}/$productId",
      );

      return List<String>.from(response.data["data"]);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<List<ProductModel>> getWishlist() async {
    try {
      final response = await _dio.get(ApiConstants.wishlistEndPoint);

      return (response.data["data"] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}
