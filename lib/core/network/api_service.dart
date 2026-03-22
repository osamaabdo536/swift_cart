import 'package:dio/dio.dart' show Dio, DioException;
import 'package:swift_cart/core/network/dio_config.dart';
import 'package:swift_cart/features/product/model/products_model.dart';

import '../../features/category/model/category_model.dart' as cat;
import '../../features/category/model/category_model.dart';
import 'api_constants.dart' show ApiConstants;
import 'api_exception.dart';

class ApiService {
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

  //////////Categories/////////

  Future<List<cat.CategoryModel>> getAllCategories() async {
    try {
      final response = await _dio.get(ApiConstants.categoriesEndPoint);
      return CategoriesResponse.fromJson(response.data).data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    try {
      final response = await _dio.get(
        ApiConstants.productsEndPoint,
        queryParameters: {'category': categoryId},
      );
      return ProductsResponse.fromJson(response.data).data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  //////////Categories///////////
}
